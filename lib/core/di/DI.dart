import 'package:baby_look/features/feature_generate/data/image_picker_repo_impl.dart';
import 'package:baby_look/features/feature_generate/domain/image_picker_repository.dart';
import 'package:baby_look/main.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> DI() async {
  getIt.registerSingleton<ImagePickerRepository>(ImagePickerRepoImpl());

  logger.i('DI initialized!');
}
