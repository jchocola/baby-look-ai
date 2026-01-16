import 'package:baby_look/core/domain/vibrattion_repository.dart';
import 'package:baby_look/main.dart';
import 'package:vibration/vibration.dart';

class VibrationRepositoryImpl implements VibrattionRepository {
  @override
  Future<bool> canVibrate() async {
    return await Vibration.hasVibrator();
  }

  @override
  Future<void> vibrate() async {
    if (await canVibrate()) {
      await Vibration.vibrate();
      logger.f('Vibrated');
    }
  }
}
