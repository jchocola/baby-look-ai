import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:baby_look/main.dart';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class BananaProService {
  static const String _baseUrl = 
      'https://generativelanguage.googleapis.com/v1beta';
  final String apiKey;
  final String modelId = 'gemini-3-pro-image-preview'; // ✅ Правильная модель
  late Dio _dio;

  BananaProService({required this.apiKey}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: Duration(seconds: 180), // Увеличил таймаут
        receiveTimeout: Duration(seconds: 180),
        headers: {
          'Content-Type': 'application/json',
          'x-goog-api-key': apiKey, // ✅ В заголовке
        },
        validateStatus: (status) => status! < 500,
      ),
    );
    
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: false, // Отключаем body в логах (очень большой)
      responseBody: false,
      logPrint: (object) => logger.d(object),
    ));
  }

  // ✅ ПОЛНЫЙ МЕТОД ДЛЯ UI
Future<Map<String, dynamic>> generateAndSavePrediction({
  required File ultrasoundImage,
  required File? fatherImage,
  required File? motherImage,
  required int gestationWeek,
  required String? gender,
  String? additionalNotes,
}) async {
  try {
    // 1. Генерируем предсказание
    final result = await generateBabyPrediction(
      ultrasoundImage: ultrasoundImage,
      fatherImage: fatherImage,
      motherImage: motherImage,
      gestationWeek: gestationWeek,
      gender: gender,
      additionalNotes: additionalNotes,
    );
    
    if (!result['success'] || result['image_bytes'] == null) {
      return {
        'success': false,
        'error': 'No image generated',
      };
    }
    
    final Uint8List imageBytes = result['image_bytes'] as Uint8List;
    
    // 2. Валидируем изображение
    await validateImage(imageBytes);
    
    // 3. Оптимизируем (опционально)
    final optimizedBytes = await optimizeImage(imageBytes);
    
    // 4. Сохраняем в файл
    final savedFile = await saveGeneratedImage(optimizedBytes);
    
    return {
      'success': true,
      'image_bytes': optimizedBytes,
      'image_file': savedFile,
      'text': result['text'],
      'image_path': savedFile?.path,
      'image_size': optimizedBytes.length,
    };
    
  } catch (e) {
    logger.e('Error in generateAndSavePrediction: $e');
    return {
      'success': false,
      'error': e.toString(),
    };
  }
}

  // ✅ ОСНОВНОЙ МЕТОД
  Future<Map<String, dynamic>> generateBabyPrediction({
    required File ultrasoundImage,
    required File? fatherImage,
    required File? motherImage,
    required int gestationWeek,
    required String? gender,
    String? additionalNotes,
  }) async {
    try {
      logger.d('=== STARTING BABY PREDICTION ===');
      
      // 1. Подготавливаем изображения
      final imageParts = await _prepareImageParts(
        ultrasoundImage: ultrasoundImage,
        fatherImage: fatherImage,
        motherImage: motherImage,
      );

      // 2. Создаем prompt для ГЕНЕРАЦИИ ИЗОБРАЖЕНИЯ
      final prompt = _buildImageGenerationPrompt(
        gestationWeek: gestationWeek,
        gender: gender,
        additionalNotes: additionalNotes,
      );

      // 3. Собираем parts: изображения -> текст
      final parts = [
        ...imageParts, // Сначала ВСЕ изображения
        {'text': prompt}, // Потом prompt
      ];

      logger.d('Total parts: ${parts.length} images + 1 text');

      // 4. Создаем запрос ТОЧНО как в curl
      final requestBody = {
        'contents': [{
          'parts': parts, // ✅ БЕЗ "role": "user"!
        }],
        // ✅ generationConfig как в curl примере (может быть пустым)
      };

      logger.d('Sending request to gemini-3-pro-image-preview...');

      // 5. Отправляем запрос
      final response = await _dio.post(
        '/models/$modelId:generateContent', // ✅ ТОЧНО как в curl
        data: requestBody,
      );

      logger.d('Response status: ${response.statusCode}');

    // ✅ Извлекаем изображение
    final imageBytes = await extractImageFromResponse(response.data);
    
    // ✅ Извлекаем текст
    final text = _extractTextFromResponse(response.data);
    
    return {
      'image_bytes': imageBytes, // ← Теперь здесь Uint8List
      'text': text,
      'success': imageBytes != null,
      'has_image': imageBytes != null,
      'image_size': imageBytes?.length ?? 0,
    };

    } catch (e) {
      logger.e('Error in generateBabyPrediction: $e');
      if (e is DioException && e.response != null) {
        logger.e('Response status: ${e.response?.statusCode}');
        logger.e('Response data keys: ${e.response?.data?.keys}');
        
        // Логируем ошибку детально
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

  // ✅ Prompt для ГЕНЕРАЦИИ ИЗОБРАЖЕНИЯ (не анализа)
  String _buildImageGenerationPrompt({
    required int gestationWeek,
    required String? gender,
    String? additionalNotes,
  }) {
    return '''
    Create a realistic newborn baby face prediction based on these images:
    
    1. First image: Ultrasound scan of the baby at $gestationWeek weeks
    2. Second image: Photo of the father' : ''}
    3ю Photo of the mother' : ''}
    
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

  // ✅ Подготовка изображений
  Future<List<Map<String, dynamic>>> _prepareImageParts({
    required File ultrasoundImage,
    required File? fatherImage,
    required File? motherImage,
  }) async {
    final parts = <Map<String, dynamic>>[];

    // Ультразвук (обязательно)
    logger.d('Processing ultrasound image...');
    parts.add(await _fileToImagePart(ultrasoundImage, 'ultrasound'));

    // Отец (если есть)
    if (fatherImage != null) {
      logger.d('Processing father image...');
      parts.add(await _fileToImagePart(fatherImage, 'father'));
    }

    // Мать (если есть)
    if (motherImage != null) {
      logger.d('Processing mother image...');
      parts.add(await _fileToImagePart(motherImage, 'mother'));
    }

    logger.d('Total images prepared: ${parts.length}');
    return parts;
  }

  // ✅ Конвертация файла
  Future<Map<String, dynamic>> _fileToImagePart(File file, String label) async {
    try {
      final bytes = await file.readAsBytes();
      logger.d('$label: ${file.path}, Size: ${bytes.length ~/ 1024}KB');
      
      // Проверка размера (Gemini ограничения)
      if (bytes.length > 20 * 1024 * 1024) { // 20MB
        throw Exception('$label image too large: ${bytes.length ~/ (1024 * 1024)}MB');
      }
      
      final base64Image = base64Encode(bytes);
      final mimeType = lookupMimeType(file.path) ?? 'image/jpeg';
      
      logger.d('$label: MIME type: $mimeType, Base64 length: ${base64Image.length}');
      
      return {
        'inline_data': {
          'mime_type': mimeType,
          'data': base64Image,
        }
      };
    } catch (e) {
      logger.e('Error processing $label image: $e');
      rethrow;
    }
  }

  // ✅ Парсинг ответа с изображением
  Map<String, dynamic> _parseImageGenerationResponse(Map<String, dynamic> responseData) {
    try {
      logger.d('Parsing image generation response...');
      
      final images = <Uint8List>[];
      final texts = <String>[];
      
      // 1. Проверяем candidates
      if (responseData['candidates'] != null) {
        final candidates = responseData['candidates'] as List;
        logger.d('Number of candidates: ${candidates.length}');
        
        for (var i = 0; i < candidates.length; i++) {
          final candidate = candidates[i];
          logger.d('Candidate $i finish reason: ${candidate['finishReason']}');
          
          if (candidate['content']?['parts'] != null) {
            final parts = candidate['content']['parts'] as List;
            logger.d('Candidate $i has ${parts.length} parts');
            
            for (var j = 0; j < parts.length; j++) {
              final part = parts[j];
              
              // Текст
              if (part['text'] != null) {
                final text = part['text'] as String;
                texts.add(text);
                logger.d('Text part $j: ${text.substring(0, min(100, text.length))}...');
              }
              
              // Изображение (inlineData)
              if (part['inlineData'] != null) {
                final inlineData = part['inlineData'];
                final mimeType = inlineData['mimeType'] as String?;
                final data = inlineData['data'] as String?;
                
                if (data != null && data.isNotEmpty) {
                  try {
                    logger.d('Found image part $j, MIME: $mimeType, data length: ${data.length}');
                    final imageBytes = base64Decode(data);
                    images.add(imageBytes);
                    logger.d('✅ Successfully decoded image: ${imageBytes.length} bytes');
                  } catch (e) {
                    logger.e('Failed to decode image: $e');
                  }
                }
              }
            }
          }
        }
      }
      
      // 2. Проверяем error
      if (responseData['error'] != null) {
        logger.e('API Error: ${responseData['error']}');
      }
      
      // 3. Проверяем usage
      if (responseData['usageMetadata'] != null) {
        final usage = responseData['usageMetadata'];
        logger.d('Tokens used - Total: ${usage['totalTokenCount']}, '
                 'Prompt: ${usage['promptTokenCount']}, '
                 'Candidates: ${usage['candidatesTokenCount']}');
      }
      
      // 4. Возвращаем результат
      return {
        'images': images,
        'text': texts.join('\n\n'),
        'success': images.isNotEmpty,
        'images_count': images.length,
        'text_length': texts.join().length,
      };
      
    } catch (e) {
      logger.e('Error parsing response: $e');
      logger.e('Raw response: ${jsonEncode(responseData).substring(0, 500)}...');
      
      return {
        'images': [],
        'text': '',
        'success': false,
        'error': e.toString(),
        'raw_response': responseData,
      };
    }
  }

  // ✅ ВСПОМОГАТЕЛЬНЫЙ МЕТОД для теста
  Future<Map<String, dynamic>> testImageGeneration() async {
    try {
      logger.d('=== TEST: Simple image generation ===');
      
      // Простейший запрос как в curl примере
      final requestBody = {
        'contents': [{
          'parts': [
            {'text': 'Generate a realistic photo of a newborn baby face'}
          ]
        }]
      };
      
      logger.d('Test request: $requestBody');
      
      final response = await _dio.post(
        '/models/$modelId:generateContent',
        data: requestBody,
      );
      
      logger.d('Test response status: ${response.statusCode}');
      
      // Проверяем, что есть кандидаты
      if (response.data['candidates'] != null) {
        logger.d('Test: Found ${response.data['candidates'].length} candidates');
      }
      
      return _parseImageGenerationResponse(response.data);
      
    } catch (e) {
      logger.e('Test failed: $e');
      return {'success': false, 'error': e.toString()};
    }
  }

  // ✅ ПРОВЕРКА КЛЮЧА И МОДЕЛИ
  Future<void> verifyApiAccess() async {
    try {
      logger.d('=== VERIFYING API ACCESS ===');
      logger.d('API Key present: ${apiKey.isNotEmpty}');
      logger.d('API Key starts with: ${apiKey.substring(0, min(10, apiKey.length))}...');
      logger.d('Model: $modelId');
      
      // Пробуем получить информацию о модели
      final response = await _dio.get(
        '/models/$modelId',
        queryParameters: {'key': apiKey},
      );
      
      logger.d('Model info: ${response.data}');
      
    } catch (e) {
      logger.e('API verification failed: $e');
    }
  }

  int min(int a, int b) => a < b ? a : b;




  // ✅ ДОБАВЬТЕ ЭТОТ МЕТОД в BananaProService
Future<Uint8List?> extractImageFromResponse(Map<String, dynamic> responseData) async {
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
          
          // ✅ ИЩЕМ inlineData (это изображение)
          if (part['inlineData'] != null) {
            final inlineData = part['inlineData'];
            final mimeType = inlineData['mimeType'] as String?;
            final data = inlineData['data'] as String?;
            
            if (data != null && data.isNotEmpty) {
              logger.d('🎉 FOUND IMAGE! Part $j, MIME: $mimeType');
              logger.d('Base64 data length: ${data.length}');
              
              try {
                // Декодируем base64 в bytes
                final imageBytes = base64Decode(data);
                logger.d('✅ Successfully decoded: ${imageBytes.length} bytes');
                
                // Можно сохранить для проверки
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

// ✅ Извлекаем текст
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

// ✅ Сохраняем изображение для отладки
Future<void> _saveImageForDebugging(Uint8List bytes, String filename) async {
  try {
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/$filename.png');
    await file.writeAsBytes(bytes);
    logger.d('📁 Image saved to: ${file.path}');
  } catch (e) {
    logger.e('Failed to save debug image: $e');
  }
}


// ✅ СОХРАНЕНИЕ ИЗОБРАЖЕНИЯ В ФАЙЛ
Future<File?> saveGeneratedImage(
  Uint8List imageBytes, {
  String fileName = 'baby_prediction',
}) async {
  try {
    // Получаем директорию для сохранения
    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final file = File('${directory.path}/$fileName$timestamp.png');
    
    // Сохраняем байты в файл
    await file.writeAsBytes(imageBytes);
    
    logger.d('✅ Image saved to: ${file.path}');
    logger.d('✅ File size: ${file.lengthSync()} bytes');
    
    return file;
  } catch (e) {
    logger.e('Error saving image: $e');
    return null;
  }
}


// ✅ КОНВЕРТАЦИЯ И ОПТИМИЗАЦИЯ ИЗОБРАЖЕНИЯ
Future<Uint8List> optimizeImage(Uint8List originalBytes) async {
  try {
    // Декодируем изображение
    final image = img.decodeImage(originalBytes);
    if (image == null) return originalBytes;
    
    // Оптимизируем размер (макс 1024x1024)
    final optimized = img.copyResize(
      image,
      width: 1024,
      height: 1024,
      interpolation: img.Interpolation.cubic,
    );
    
    // Кодируем обратно в PNG с сжатием
    final optimizedBytes = img.encodePng(optimized, level: 6);
    
    logger.d('Image optimized: ${originalBytes.length} → ${optimizedBytes.length} bytes');
    
    return Uint8List.fromList(optimizedBytes);
  } catch (e) {
    logger.e('Error optimizing image: $e');
    return originalBytes;
  }
}


// ✅ ПРОВЕРКА ИЗОБРАЖЕНИЯ (что это валидное изображение)
Future<void> validateImage(Uint8List imageBytes) async {
  try {
    // Пробуем декодировать
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
}