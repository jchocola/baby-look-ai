import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/core/app_theme/app_color.dart';
import 'package:baby_look/shared/custom_button_with_icon.dart';
import 'package:flutter/material.dart';

class UploadParentPhotoCard extends StatelessWidget {
  const UploadParentPhotoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.blueColor3,
      child: Column(
        spacing: AppConstant.appPadding,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Icon(AppIcon.imageIcon),
            Text("Mother's Photo"),
            Text('Clear frontal photo for best results'),

             Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButtonWithIcon(icon: AppIcon.imageIcon, title: 'Gallery'),
              CustomButtonWithIcon(icon: AppIcon.cameratIcon, title: 'Camera'),
            ],
          ),
        ],
      ),
    );
  }
}
