import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/core/app_theme/app_theme.dart';
import 'package:baby_look/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter, title: 'AI BabyLook');
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
        onTap: (value){
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
