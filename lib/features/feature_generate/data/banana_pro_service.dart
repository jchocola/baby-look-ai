import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:math';

import 'package:baby_look/main.dart';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class BananaProService {
  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta';
  final String apiKey;
  final String modelId = 'gemini-3-pro-image-preview';
  late Dio _dio;

  BananaProService({required this.apiKey}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: Duration(seconds: 180),
        receiveTimeout: Duration(seconds: 180),
        headers: {
          'Content-Type': 'application/json',
          'x-goog-api-key': apiKey, // Exactly like curl example
        },
        validateStatus: (status) => status! < 500,
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: false,
        responseBody: false,
        logPrint: (object) => logger.d(object),
      ),
    );
  }

  /// Simple public interface for UI
  /// Generates baby prediction and returns file path
  Future<Map<String, dynamic>> generateBabyPrediction({
    required File ultrasoundImage,
    File? fatherImage,
    File? motherImage,
    required int gestationWeek,
    String? gender,
    String? additionalNotes,
  }) async {
    try {
      // 1. Generate prediction image
      final result = await _generateBabyImage(
        ultrasoundImage: ultrasoundImage,
        fatherImage: fatherImage,
        motherImage: motherImage,
        gestationWeek: gestationWeek,
        gender: gender,
        additionalNotes: additionalNotes,
      );

      if (!result['success'] || result['image_bytes'] == null) {
        return {'success': false, 'error': 'No image generated'};
      }

      final Uint8List imageBytes = result['image_bytes'] as Uint8List;

      // 2. Validate the generated image
      await _validateImage(imageBytes);

      // 3. Optimize image size (optional)
      final optimizedBytes = await _optimizeImage(imageBytes);

      // 4. Save to file system
      final savedFile = await _saveGeneratedImage(optimizedBytes);

      return {
        'success': true,
        'image_bytes': optimizedBytes,
        'image_file': savedFile,
        'text': result['text'],
        'image_path': savedFile?.path,
        'image_size': optimizedBytes.length,
      };
    } catch (e) {
      logger.e('Error in generateBabyPrediction: $e');
      return {'success': false, 'error': e.toString()};
    }
  }

  /// Internal method that handles the actual API call
  Future<Map<String, dynamic>> _generateBabyImage({
    required File ultrasoundImage,
    required File? fatherImage,
    required File? motherImage,
    required int gestationWeek,
    required String? gender,
    String? additionalNotes,
  }) async {
    try {
      logger.d('=== STARTING BABY PREDICTION ===');

      // 1. Prepare all input images
      final imageParts = await _prepareImageParts(
        ultrasoundImage: ultrasoundImage,
        fatherImage: fatherImage,
        motherImage: motherImage,
      );

      // 2. Build generation prompt
      final prompt = _buildImageGenerationPrompt(
        gestationWeek: gestationWeek,
        gender: gender,
        additionalNotes: additionalNotes,
      );

      // 3. Combine images and prompt
      final parts = [
        ...imageParts, // Images first
        {'text': prompt}, // Prompt last
      ];

      logger.d('Total parts: ${parts.length} images + 1 text');

      // 4. Create request exactly matching curl example
      final requestBody = {
        'contents': [
          {
            'parts': parts, // No "role": "user"!
          },
        ],
      };

      logger.d('Sending request to gemini-3-pro-image-preview...');

      // 5. Make API call
      final response = await _dio.post(
        '/models/$modelId:generateContent', // Exactly like curl
        data: requestBody,
      );

      logger.d('Response status: ${response.statusCode}');

      // Extract generated image and text
      final imageBytes = await _extractImageFromResponse(response.data);
      final text = _extractTextFromResponse(response.data);

      return {
        'image_bytes': imageBytes,
        'text': text,
        'success': imageBytes != null,
        'has_image': imageBytes != null,
        'image_size': imageBytes?.length ?? 0,
      };
    } catch (e) {
      logger.e('Error in _generateBabyImage: $e');
      if (e is DioException && e.response != null) {
        logger.e('Response status: ${e.response?.statusCode}');
        logger.e('Response data keys: ${e.response?.data?.keys}');

        if (e.response?.data is Map) {
          final errorData = e.response!.data as Map;
          if (errorData['error'] != null) {
            logger.e('API Error: ${errorData['error']}');
          }
        }
      }
      rethrow;
    }
  }

  /// Build prompt for image generation
  String _buildImageGenerationPrompt({
    required int gestationWeek,
    required String? gender,
    String? additionalNotes,
  }) {
    return '''
    Create a realistic newborn baby face prediction based on these images:
    
    1. First image: Ultrasound scan of the baby at $gestationWeek weeks
    2. Second image: Photo of the father (if provided)
    3. Third image: Photo of the mother (if provided)
    
    Baby gender: ${gender ?? 'unknown'}
    ${additionalNotes != null ? 'Additional notes: $additionalNotes' : ''}
    
    Generate ONE realistic photo of how the newborn baby might look.
    
    Important instructions:
    - Generate a PHOTO-REALISTIC newborn baby face
    - The baby should look like a real newborn (0-1 month old)
    - Consider genetic features from parent photos if provided
    - Newborn characteristics: rounded face, delicate features, soft skin
    - Professional photography quality, soft lighting
    - Front-facing portrait, clear facial features
    - Background: soft neutral color (white or light gray)
    - Output format: high-quality image
    ''';
  }

  /// Prepare images for API request
  Future<List<Map<String, dynamic>>> _prepareImageParts({
    required File ultrasoundImage,
    required File? fatherImage,
    required File? motherImage,
  }) async {
    final parts = <Map<String, dynamic>>[];

    // Ultrasound (required)
    logger.d('Processing ultrasound image...');
    parts.add(await _fileToImagePart(ultrasoundImage, 'ultrasound'));

    // Father (optional)
    if (fatherImage != null) {
      logger.d('Processing father image...');
      parts.add(await _fileToImagePart(fatherImage, 'father'));
    }

    // Mother (optional)
    if (motherImage != null) {
      logger.d('Processing mother image...');
      parts.add(await _fileToImagePart(motherImage, 'mother'));
    }

    logger.d('Total images prepared: ${parts.length}');
    return parts;
  }

  /// Convert file to API-ready image part
  Future<Map<String, dynamic>> _fileToImagePart(File file, String label) async {
    try {
      final bytes = await file.readAsBytes();
      logger.d('$label: ${file.path}, Size: ${bytes.length ~/ 1024}KB');

      // Check size limits (Gemini restrictions)
      if (bytes.length > 20 * 1024 * 1024) {
        // 20MB
        throw Exception(
          '$label image too large: ${bytes.length ~/ (1024 * 1024)}MB',
        );
      }

      final base64Image = base64Encode(bytes);
      final mimeType = lookupMimeType(file.path) ?? 'image/jpeg';

      logger.d(
        '$label: MIME type: $mimeType, Base64 length: ${base64Image.length}',
      );

      return {
        'inline_data': {'mime_type': mimeType, 'data': base64Image},
      };
    } catch (e) {
      logger.e('Error processing $label image: $e');
      rethrow;
    }
  }

  /// Extract image from API response
  Future<Uint8List?> _extractImageFromResponse(
    Map<String, dynamic> responseData,
  ) async {
    try {
      logger.d('=== EXTRACTING IMAGE FROM RESPONSE ===');

      if (responseData['candidates'] == null) {
        logger.d('No candidates in response');
        return null;
      }

      final candidates = responseData['candidates'] as List;
      logger.d('Found ${candidates.length} candidates');

      for (var i = 0; i < candidates.length; i++) {
        final candidate = candidates[i];

        if (candidate['content']?['parts'] != null) {
          final parts = candidate['content']['parts'] as List;
          logger.d('Candidate $i has ${parts.length} parts');

          for (var j = 0; j < parts.length; j++) {
            final part = parts[j];

            // Look for inlineData (the generated image)
            if (part['inlineData'] != null) {
              final inlineData = part['inlineData'];
              final mimeType = inlineData['mimeType'] as String?;
              final data = inlineData['data'] as String?;

              if (data != null && data.isNotEmpty) {
                logger.d('🎉 FOUND IMAGE! Part $j, MIME: $mimeType');
                logger.d('Base64 data length: ${data.length}');

                try {
                  // Decode base64 to bytes
                  final imageBytes = base64Decode(data);
                  logger.d(
                    '✅ Successfully decoded: ${imageBytes.length} bytes',
                  );

                  // Save for debugging
                  await _saveImageForDebugging(imageBytes, 'generated_baby_$i');

                  return imageBytes;
                } catch (e) {
                  logger.e('Failed to decode base64: $e');
                }
              }
            }
          }
        }
      }

      logger.d('No image found in response');
      return null;
    } catch (e) {
      logger.e('Error extracting image: $e');
      return null;
    }
  }

  /// Extract text description from response
  String _extractTextFromResponse(Map<String, dynamic> responseData) {
    try {
      if (responseData['candidates'] != null) {
        final candidates = responseData['candidates'] as List;

        for (final candidate in candidates) {
          if (candidate['content']?['parts'] != null) {
            final parts = candidate['content']['parts'] as List;

            for (final part in parts) {
              if (part['text'] != null) {
                return part['text'] as String;
              }
            }
          }
        }
      }
      return '';
    } catch (e) {
      logger.e('Error extracting text: $e');
      return '';
    }
  }

  /// Validate that bytes represent a valid image
  Future<void> _validateImage(Uint8List imageBytes) async {
    try {
      final image = img.decodeImage(imageBytes);

      if (image != null) {
        logger.d('✅ Image is valid!');
        logger.d('  Dimensions: ${image.width}x${image.height}');
        logger.d('  Format: PNG (assumed)');
      } else {
        logger.e('❌ Failed to decode image');
      }
    } catch (e) {
      logger.e('Error validating image: $e');
    }
  }

  /// Optimize image size and quality
  Future<Uint8List> _optimizeImage(Uint8List originalBytes) async {
    try {
      final image = img.decodeImage(originalBytes);
      if (image == null) return originalBytes;

      // Resize to max 1024x1024
      final optimized = img.copyResize(
        image,
        width: 1024,
        height: 1024,
        interpolation: img.Interpolation.cubic,
      );

      // Encode with compression
      final optimizedBytes = img.encodePng(optimized, level: 6);

      logger.d(
        'Image optimized: ${originalBytes.length} → ${optimizedBytes.length} bytes',
      );

      return Uint8List.fromList(optimizedBytes);
    } catch (e) {
      logger.e('Error optimizing image: $e');
      return originalBytes;
    }
  }

  /// Save generated image to file system
  Future<File?> _saveGeneratedImage(
    Uint8List imageBytes, {
    String fileName = 'baby_prediction',
  }) async {
    try {
      final directory = await getDownloadsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File('${directory?.path}/$fileName$timestamp.png');

      await file.writeAsBytes(imageBytes);

      logger.d('✅ Image saved to: ${file.path}');
      logger.d('✅ File size: ${file.lengthSync()} bytes');

      return file;
    } catch (e) {
      logger.e('Error saving image: $e');
      return null;
    }
  }

  /// Save image for debugging purposes
  Future<void> _saveImageForDebugging(Uint8List bytes, String filename) async {
    try {
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/$filename.png');
      await file.writeAsBytes(bytes);
      logger.d('📁 Debug image saved to: ${file.path}');
    } catch (e) {
      logger.e('Failed to save debug image: $e');
    }
  }
}
