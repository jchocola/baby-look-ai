import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/features/feature_generate/widget/baby_gender_picker.dart';
import 'package:baby_look/features/feature_generate/widget/gestation_week.dart';
import 'package:baby_look/shared/custom_app_bar.dart';
import 'package:baby_look/shared/custom_button_with_icon.dart';
import 'package:baby_look/shared/note_widget.dart';
import 'package:baby_look/shared/tips_card.dart';
import 'package:flutter/material.dart';

class GeneratePage2 extends StatelessWidget {
  const GeneratePage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Step2: Baby Information (Optional)'),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(AppConstant.appPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppConstant.appPadding,
        children: [
         NoteWidget(
          color: theme.colorScheme.tertiary,
          icon: AppIcon.infoIcon,
          note: "This information helps our AI provide more accurate predictions tailored to your baby's development stage.",),
          
          GestationWeek(),
          BabyGenderPicker(),
          TipsCard(
            cardColor: theme.colorScheme.errorContainer,
            iconColor: theme.colorScheme.error,
            icon: AppIcon.ideaIcon,
            title: 'Best Results',subtitle: "Weeks 24-28 provide the clearest ultrasound images for AI analysis.",)
        ],
      ),
    );
  }
}
