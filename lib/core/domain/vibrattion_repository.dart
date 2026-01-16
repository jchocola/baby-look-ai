abstract class VibrattionRepository {
  Future<bool> canVibrate();

  Future<void> vibrate();
}
