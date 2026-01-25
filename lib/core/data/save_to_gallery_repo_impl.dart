import 'dart:io';
import 'dart:typed_data';

import 'package:baby_look/core/app_exception/app_exception.dart';
import 'package:baby_look/core/domain/save_to_gallery_repository.dart';
import 'package:baby_look/main.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class SaveToGalleryRepoImpl implements SaveToGalleryRepository {
  @override
  Future<String> saveImageBytesToGallery({
    required Uint8List imageBytes,
  }) async {
    try {
      final directory = await getDownloadsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File('${directory?.path}/baby_prediction_$timestamp.png');

      if (!await file.exists()) {
        await file.create(recursive: true);
      }

      await file.writeAsBytes(imageBytes);
      logger.i('File saved in ${file.path}');
      return file.path;
    } catch (e) {
      logger.e(e);
      throw AppException.failed_to_save_image_byte_to_gallery;
    }
  }

  @override
  Future<String> saveInternetImageToGallery({required String imageUrl}) async {
    try {
      final directory = await getDownloadsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File('${directory?.path}/baby_prediction_$timestamp.png');
      logger.d(file.path);
      await Dio().download(imageUrl, file.path);
      logger.f("saveInterImageToGallery completed");
      return file.path;
    } catch (e) {
      logger.e(e);
      throw 'failed to save image from gallerry';
    }
  }
}
