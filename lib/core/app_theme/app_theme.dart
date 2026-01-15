import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_theme/app_color.dart';
import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColor.whitColor,  // BACKGROUND

  indicatorColor: AppColor.blueColor3,

  ///
  /// COLOR SCHEME
  ///
  colorScheme: ColorScheme.light(
    primary: AppColor.pinkColor,

    secondary: AppColor.grayColor,

    tertiary: AppColor.blueColor,

  ),

  ///
  /// BOTTOM NAVBAR
  ///
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColor.grayColor,
    selectedItemColor: AppColor.pinkColor,
    unselectedItemColor: AppColor.grayColor,
    showUnselectedLabels: true,
    showSelectedLabels: true
      ),


   ///
   /// APPBAR
   ///   
   appBarTheme: AppBarTheme(
    actionsPadding: EdgeInsets.only(right: AppConstant.appPadding),
   ),


   dividerTheme: DividerThemeData(
    color: AppColor.grayColor.withOpacity(0.3)
   )
);
