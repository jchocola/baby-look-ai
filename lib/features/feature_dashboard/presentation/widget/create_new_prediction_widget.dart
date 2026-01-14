import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/core/app_theme/app_color.dart';
import 'package:baby_look/shared/custom_rounded_icon.dart';
import 'package:flutter/material.dart';

class CreateNewPredictionWidget extends StatelessWidget {
  const CreateNewPredictionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context);
    return Container(
      color: AppColor.pinkColor,
      child: Row(
        spacing: AppConstant.appPadding,
        children: [
          CustomRoundedIcon(),
          Column(
            children: [
              Text('Create New Prediction'),
              Text('Upload ultrasound and parent photos')
            ],
          ),
          Icon(AppIcon.arrowForwardIcon)
        ],
      ),
    );
  }
}
