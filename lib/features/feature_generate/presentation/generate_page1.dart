import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/features/feature_generate/widget/tips_for_best_result.dart';
import 'package:baby_look/features/feature_generate/widget/upload_ultrasound_widget.dart';
import 'package:baby_look/shared/custom_app_bar.dart';
import 'package:baby_look/shared/custom_button_with_icon.dart';
import 'package:baby_look/shared/note_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GeneratePage1 extends StatelessWidget {
  const GeneratePage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Step 1: Upload Ultrasound'),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppConstant.appPadding),
      child: Column(
        spacing: AppConstant.appPadding,
        children: [
          UploadUltrasoundWidget(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButtonWithIcon(icon: AppIcon.imageIcon, title: 'Gallery'),
              CustomButtonWithIcon(icon: AppIcon.cameratIcon, title: 'Camera'),
            ],
          ),
          TipsForBestResult(),
          NoteWidget(),
        ],
      ),
    );
  }
}
