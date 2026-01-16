import 'dart:io';

import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:flutter/material.dart';

class SmallPickedImageCard extends StatelessWidget {
  const SmallPickedImageCard({super.key, required this.file});
  final File file;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.2;
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(AppConstant.borderRadius),
      child: SizedBox(
        width: size,
        height: size,
        child: Image.file(file, fit: BoxFit.cover,),
      ),
    );
  }
}
