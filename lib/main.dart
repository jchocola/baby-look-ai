import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/core/app_theme/app_theme.dart';
import 'package:baby_look/core/di/DI.dart';
import 'package:baby_look/core/router/app_router.dart';
import 'package:baby_look/features/feature_generate/bloc/generating_bloc.dart';
import 'package:baby_look/features/feature_generate/bloc/prepare_data_bloc.dart';
import 'package:baby_look/features/feature_generate/data/banana_pro_service.dart';
import 'package:baby_look/features/feature_generate/domain/image_picker_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/web.dart';
import 'package:toastification/toastification.dart';

final logger = Logger();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // .env
  await dotenv.load(fileName: ".env");

  // DI
  await DI();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> PrepareDataBloc(pickerRepository: getIt<ImagePickerRepository>())),
         BlocProvider(create: (context)=> GeneratingBloc(bananaProService: getIt<BananaProService>())),
      ],
      child: ToastificationWrapper(
        
        child: MaterialApp.router(
          theme: appTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
          title: 'AI BabyLook',
        ),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (value) {
          navigationShell.goBranch(value);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(AppIcon.homeIcon), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(AppIcon.createIcon),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcon.galleryIcon),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(icon: Icon(AppIcon.userIcon), label: 'User'),
        ],
      ),
    );
  }
}
