abstract class LocalNotifcationRepository {
  Future<void> init();
  Future <void> showNotification({required String title,required String body, String ?channel_id,String?channel_name});

}
