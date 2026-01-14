import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/features/feature_generate/widget/baby_gender_picker.dart';
import 'package:baby_look/features/feature_generate/widget/gestation_week.dart';
import 'package:baby_look/features/feature_generate/widget/tips_for_best_result.dart';
import 'package:baby_look/features/feature_generate/widget/upload_parent_photo.dart';
import 'package:baby_look/features/feature_generate/widget/upload_ultrasound_widget.dart';
import 'package:baby_look/shared/big_button.dart';
import 'package:baby_look/shared/custom_app_bar.dart';
import 'package:baby_look/shared/custom_button_with_icon.dart';
import 'package:baby_look/shared/note_widget.dart';
import 'package:baby_look/shared/tips_card.dart';
import 'package:flutter/material.dart';

class GeneratePage3 extends StatelessWidget {
  const GeneratePage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Step3: Parent Photos'),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppConstant.appPadding),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppConstant.appPadding,
          children: [
            Text('Upload Parent Photos'),
            Text("Clear photos of both parents help our AI generate a more accurate baby prediction"),
        
            Row(children: [
              Expanded(
                child: TipsCard(
                  title: "Good Lighting",
                  subtitle: "Use natural light or well-lit indoor environment",
                ),
              ),
              Expanded(child: TipsCard(title: "Clear Face", subtitle: "Ensure face is clearly visible and in focus",)),
            ],),
        
              Row(children: [
              Expanded(
                child: TipsCard(
                  title: "Face Fills Frame",
                  subtitle: "Position face to fill most of the frame",
                ),
              ),
              Expanded(child: TipsCard(title: "Natural Expression", subtitle: "Neutral or natural expression works best",)),
            ],),
        
              NoteWidget(note: "Tip.Frontal photos with neutral backgrounds work best for accurate predictions",),
            UploadParentPhotoCard(),
            UploadParentPhotoCard(),
         
          
            BigButton(title: 'Generate Prediction',),
              BigButton(title: 'Cancel',),

            Text("Both parent photos are required to generate an accurate prediction"),
          ],
        ),
      ),
    );
  }
}
