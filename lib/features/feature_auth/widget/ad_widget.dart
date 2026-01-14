import 'package:baby_look/core/app_theme/app_color.dart';
import 'package:flutter/material.dart';

class AdWidget extends StatelessWidget {
  const AdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.5,
      height:  size.width * 0.5,
      color: AppColor.yellowColor,
      child: Center(child: Text('Video')),
    );
  }
}
