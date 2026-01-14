import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/core/app_theme/app_color.dart';
import 'package:flutter/material.dart';

class UploadUltrasoundWidget extends StatelessWidget {
  const UploadUltrasoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.blueColor3,
      child: Column(
        spacing: AppConstant.appPadding,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Icon(AppIcon.imageIcon),
            Text('Upload Ultrasound Scan'),
            Text('Select your clearest ultrasound image')
        ],
      ),
    );
  }
}
