import 'dart:io';

import 'package:baby_look/core/domain/share_image_repository.dart';
import 'package:baby_look/main.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class SharePlusShareImageRepoImpl implements ShareImageRepository {
  @override
  Future<void> shareImage({required String imageUrl , String? content}) async {
    try {
      // 1) save file
      final dir = await getDownloadsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File('${dir?.path}/baby_prediction_$timestamp.png');
      await Dio().download(imageUrl, file.path);

      if (await file.exists()) {
        // 2) share
        final params = ShareParams(
          text: content ??  'Great picture',
          files: [XFile(file.path)],
        );

        final result = await SharePlus.instance.share(params);

        if (result.status == ShareResultStatus.success) {
          logger.e('Thank you for sharing the picture!');
        }

        // 3) clear file
        await file.delete();
      }
    } catch (e) {
      logger.e(e);
    }
  }
}
