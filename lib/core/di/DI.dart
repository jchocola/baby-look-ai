import 'package:baby_look/core/data/vibration_repository_impl.dart';
import 'package:baby_look/core/domain/vibrattion_repository.dart';
import 'package:baby_look/features/feature_auth/data/firebase_auth_repository_impl.dart';
import 'package:baby_look/features/feature_auth/domain/repository/auth_repository.dart';
import 'package:baby_look/features/feature_generate/data/banana_pro_service.dart';
import 'package:baby_look/features/feature_generate/data/firebase_prediction_db_repo_impl.dart';
import 'package:baby_look/features/feature_generate/data/image_picker_repo_impl.dart';
import 'package:baby_look/features/feature_generate/domain/image_picker_repository.dart';
import 'package:baby_look/features/feature_generate/domain/prediction_db_repository.dart';
import 'package:baby_look/features/feature_user/data/firebase_user_db_repo_impl.dart';
import 'package:baby_look/features/feature_user/domain/repo/user_db_repository.dart';
import 'package:baby_look/main.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> DI() async {
  getIt.registerSingleton<ImagePickerRepository>(ImagePickerRepoImpl());

  getIt.registerSingleton<BananaProService>(
    BananaProService(apiKey: dotenv.env['GEMINI_API_KEY'] ?? ''),
  );

  getIt.registerSingleton<VibrattionRepository>(VibrationRepositoryImpl());

  getIt.registerSingleton<AuthRepository>(FirebaseAuthRepositoryImpl());

  getIt.registerSingleton<UserDbRepository>(FirebaseUserDbRepoImpl());

  getIt.registerSingleton<PredictionDbRepository>(
    FirebasePredictionDbRepoImpl(),
  );

  logger.i('DI initialized!');
}
