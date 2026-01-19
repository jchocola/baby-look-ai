import 'package:baby_look/main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:baby_look/core/domain/local_db_repository.dart';

class SharedLocaldbrepositoryImpl implements LocalDbRepository {
  final SharedPreferences prefs;
  SharedLocaldbrepositoryImpl({required this.prefs});

  ///
  /// KEYS
  ///
  final String notificationEnability = 'NOTIFICATION_ENABILITY';

  @override
  Future<bool> getNotificationEnablity() async {
    return prefs.getBool(notificationEnability) ?? false;
  }

  @override
  Future<void> toogleEnablityNotification() async {
    final currentValue = await getNotificationEnablity();
    if (currentValue == false) {
      final isGranted = await _checkNotificationPermission();

      if (!isGranted) {
        final stattus = await _requestNotificationPermission();
        if (stattus.isPermanentlyDenied) {
          await openAppSettings();
        }

        if (!stattus.isGranted) {
          return;
        }
      }
    }

    logger.i('Toogle Notification Enability : ${!currentValue}');
    await prefs.setBool(notificationEnability, !currentValue);
  }

  Future<PermissionStatus> _requestNotificationPermission() async {
    try {
      final status = await Permission.notification.request();
      logger.f(status);
      return status;
    } catch (e) {
      logger.e(e);
      throw 'SOME ERROR';
    }
  }

  Future<bool> _checkNotificationPermission() async {
    try {
      return await Permission.notification.isGranted;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }
}
