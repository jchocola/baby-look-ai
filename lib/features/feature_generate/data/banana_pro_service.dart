import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:baby_look/main.dart';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';

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
        connectTimeout: Duration(seconds: 120),
        receiveTimeout: Duration(seconds: 120),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // Добавляем interceptor для логирования
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (object) => logger.d(object),
    ));
  }

  // Sử dụng compute cho heavy operations
  Future<Map<String, dynamic>> generateBabyPrediction({
    required File ultrasoundImage,
    required File? fatherImage,
    required File? motherImage,
    required int gestationWeek,
    required String? gender,
    required String? additionalNotes,
  }) async {
    try {
      // Tạo prompt từ thông tin người dùng
      final prompt = _buildPredictionPrompt(
        gestationWeek: gestationWeek,
        gender: gender,
      );
      logger.f('Prompt: $prompt');

      // Chuẩn bị các parts (text + images)
      final parts = await _prepareImageParts(
        ultrasoundImage: ultrasoundImage,
        fatherImage: fatherImage,
        motherImage: motherImage,
        prompt: prompt,
      );

      // Tạo request body
      final requestBody = {
        'contents': [
          {'role': 'user', 'parts': parts},
        ],
        'generationConfig': {
          'responseModalities': ['IMAGE', 'TEXT'],
          'imageConfig': {'image_size': '1K'},
          'responseStreaming': true, // ← ЭТО КРИТИЧЕСКИ ВАЖНО!
          'temperature': 0.7
        },
      };

      // Gọi API
      final response = await _dio.post(
        '/models/$modelId:streamGenerateContent',
        queryParameters: {'key': apiKey},
        data: requestBody,
        options: Options(
          responseType: ResponseType.stream, // ← ЭТО ОБЯЗАТЕЛЬНО!
        ),
      );

      logger.d('API responded with status: ${response.statusCode}');

      return _parseResponse(response.data);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  // Xây dựng prompt chi tiết
  String _buildPredictionPrompt({
    required int gestationWeek,
    required String? gender,
    String? additionalNotes,
  }) {
    String genderPrompt = gender != null
        ? "The baby's gender is $gender."
        : "The baby's gender is unknown.";

    return '''
    You are a baby prediction AI for expecting parents. 
    
    I have provided:
    1. An ultrasound image of the baby (first image)
    2. A photo of the father (second image, if provided)
    3. A photo of the mother (third image, if provided)
    
    Additional information:
    - Gestation week: $gestationWeek
    - $genderPrompt
    ${additionalNotes != null ? '- Additional notes: $additionalNotes' : ''}
    
    Please analyze these images and generate:
    1. A realistic image of how the baby might look after birth
    2. A text description explaining:
       - Predominant facial features inherited from parents
       - Probable eye color, hair color/texture
       - Any distinctive features
       - Confidence level of predictions
    
    Important guidelines:
    - The generated baby image should be realistic and appropriate
    - Consider genetic inheritance patterns
    - Account for gestation week in feature development
    - If parent photos are missing, use common features for the given gender/ethnicity
    - The ultrasound quality may vary, use your best judgment
    - Output should be hopeful and positive for expecting parents
    ''';
  }

  // Chuẩn bị image parts cho API
  Future<List<Map<String, dynamic>>> _prepareImageParts({
    required File ultrasoundImage,
    required File? fatherImage,
    required File? motherImage,
    required String prompt,
  }) async {
    final parts = <Map<String, dynamic>>[
      {'text': prompt},
    ];

    // Thêm ảnh siêu âm
    parts.add(await _fileToImagePart(ultrasoundImage, 'ultrasound'));

    // Thêm ảnh bố nếu có
    if (fatherImage != null) {
      parts.add(await _fileToImagePart(fatherImage, 'father'));
    }

    // Thêm ảnh mẹ nếu có
    if (motherImage != null) {
      parts.add(await _fileToImagePart(motherImage, 'mother'));
    }

    return parts;
  }

  // Chuyển File thành định dạng image part cho Gemini
  Future<Map<String, dynamic>> _fileToImagePart(File file, String tag) async {
    final bytes = await file.readAsBytes();
    final base64Image = base64Encode(bytes);
    final mimeType = lookupMimeType(file.path) ?? 'image/jpeg';

    return {
      'inline_data': {'mime_type': mimeType, 'data': base64Image},
    };
  }

  // Parse response từ API
  Map<String, dynamic> _parseResponse(dynamic responseData) {
    // Gemini streamGenerateContent trả về stream, cần parse từng chunk
    if (responseData is Map<String, dynamic>) {
      return responseData;
    }

    // Xử lý stream response
    final responseString = responseData.toString();
    final lines = responseString.split('\n');

    final images = <String>[];
    final texts = <String>[];

    for (final line in lines) {
      if (line.trim().isEmpty) continue;

      try {
        final jsonData = jsonDecode(line);

        logger.d(jsonData);

        if (jsonData['candidates'] != null &&
            jsonData['candidates'][0]['content']['parts'] != null) {
          for (final part in jsonData['candidates'][0]['content']['parts']) {
            if (part['text'] != null) {
              texts.add(part['text']);
            } else if (part['inlineData'] != null) {
              images.add(part['inlineData']['data']);
            }
          }
        }
      } catch (e) {
        // Bỏ qua lines không phải JSON
        continue;
      }
    }

    return {'images': images, 'text': texts.join('\n')};
  }

  // Phương thức helper để upload ảnh đơn giản
  Future<String?> uploadImageAndGetPrediction(File image, String prompt) async {
    try {
      final bytes = await image.readAsBytes();
      final base64Image = base64Encode(bytes);
      final mimeType = lookupMimeType(image.path) ?? 'image/jpeg';

      final requestBody = {
        'contents': [
          {
            'role': 'user',
            'parts': [
              {'text': prompt},
              {
                'inline_data': {'mime_type': mimeType, 'data': base64Image},
              },
            ],
          },
        ],
        'generationConfig': {
          'responseModalities': ['IMAGE', 'TEXT'],
          'imageConfig': {'image_size': '1K'},
        },
      };

      final response = await _dio.post(
        '/models/$modelId:streamGenerateContent',
        queryParameters: {'key': apiKey},
        data: requestBody,
        options: Options(responseType: ResponseType.stream),
      );

      return await _processStreamResponse(response);
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }

  Future<String?> _processStreamResponse(Response response) async {
    final completer = Completer<String?>();
    final buffer = StringBuffer();

    response.data.stream.listen(
      (chunk) {
        final chunkString = utf8.decode(chunk);
        buffer.write(chunkString);

        // Parse từng dòng JSON trong stream
        final lines = chunkString.split('\n');
        for (final line in lines) {
          if (line.trim().isEmpty) continue;
          try {
            final jsonData = jsonDecode(line);
            print('Received chunk: ${jsonData.keys}');
          } catch (e) {
            // Continue
          }
        }
      },
      onDone: () {
        completer.complete(buffer.toString());
      },
      onError: (error) {
        completer.completeError(error);
      },
    );

    return completer.future;
  }
}
