import 'dart:io';

import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:flutter/material.dart';

class PickedImageCard extends StatelessWidget {
  const PickedImageCard({super.key, required this.file, this.onCancelPressed});

  final File file;
  final void Function()? onCancelPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      
       Positioned.fill(child: Image.file(file, fit: BoxFit.cover)),
       Positioned( 
        top: AppConstant.appPadding/2,
        right: AppConstant.appPadding/2,
        child: IconButton(onPressed: onCancelPressed, icon: Icon(AppIcon.cancelIcon))),
    ]);
  }
}
