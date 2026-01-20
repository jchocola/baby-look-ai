import 'package:baby_look/features/feature_notification/domain/local_notifcation_repository.dart';
import 'package:baby_look/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class FlutterLocalNotificationRepositoryImpl
    implements LocalNotifcationRepository {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Future<void> init() async {
    // Настройка для Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/notification_ic');

    // Настройка для iOS
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
        );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    logger.i('Local notification inited');
  }

  @override
  Future<void> showNotification({
    required String title,
    required String body,
    String? channel_id,
    String? channel_name,
  }) async {
    try {
     

      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
            channel_id ?? 'channel_id',
            channel_name ?? 'channel_name',
            importance: Importance.max,
            priority: Priority.high,
          );

      const DarwinNotificationDetails darwinNotificationDetails =
          DarwinNotificationDetails();

      NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: darwinNotificationDetails,
      );

      await flutterLocalNotificationsPlugin.show(
        0,
        'Заголовок уведомления',
        'Текст уведомления',
        platformChannelSpecifics,
      );
    } catch (e) {
      logger.e(e);
    }
  }


}
