import 'package:baby_look/core/data/shared_localDBrepository_impl.dart';
import 'package:baby_look/core/data/vibration_repository_impl.dart';
import 'package:baby_look/core/domain/local_db_repository.dart';
import 'package:baby_look/core/domain/vibrattion_repository.dart';
import 'package:baby_look/features/feature_auth/data/firebase_auth_repository_impl.dart';
import 'package:baby_look/features/feature_auth/domain/repository/auth_repository.dart';
import 'package:baby_look/features/feature_generate/data/banana_pro_service.dart';
import 'package:baby_look/features/feature_generate/data/firebase_prediction_db_repo_impl.dart';
import 'package:baby_look/features/feature_generate/data/image_picker_repo_impl.dart';
import 'package:baby_look/features/feature_generate/domain/image_picker_repository.dart';
import 'package:baby_look/features/feature_generate/domain/prediction_db_repository.dart';
import 'package:baby_look/features/feature_notification/data/flutter_local_notification_repository_impl.dart';
import 'package:baby_look/features/feature_notification/domain/local_notifcation_repository.dart';
import 'package:baby_look/features/feature_user/data/firebase_user_db_repo_impl.dart';
import 'package:baby_look/features/feature_user/domain/repo/user_db_repository.dart';
import 'package:baby_look/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    FirebasePredictionDbRepoImpl(userDbRepository: getIt<UserDbRepository>()),
  );

  getIt.registerSingleton<LocalNotifcationRepository>(
    FlutterLocalNotificationRepositoryImpl(),
  );

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<LocalDbRepository>(SharedLocaldbrepositoryImpl(prefs: prefs));

  logger.i('DI initialized!');
}
