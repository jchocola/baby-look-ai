import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/core/app_text/app_text.dart';
import 'package:baby_look/features/feature_generate/widget/baby_gender_picker.dart';
import 'package:baby_look/features/feature_generate/widget/gestation_week.dart';
import 'package:baby_look/shared/custom_app_bar.dart';
import 'package:baby_look/shared/custom_button_with_icon.dart';
import 'package:baby_look/shared/note_widget.dart';
import 'package:baby_look/shared/tips_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class GeneratePage2 extends StatelessWidget {
  const GeneratePage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.tr(AppText.step2_appbar)),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(AppConstant.appPadding),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppConstant.appPadding,
          children: [
            NoteWidget(
              color: theme.colorScheme.tertiary,
              icon: AppIcon.infoIcon,
              note: context.tr(AppText.step2_note),
            ),
        
            GestationWeek(),
            BabyGenderPicker(),
            TipsCard(
              cardColor: theme.colorScheme.errorContainer,
              iconColor: theme.colorScheme.error,
              icon: AppIcon.ideaIcon,
              title: context.tr(AppText.step2_tip_title),
              subtitle: context.tr(AppText.step2_tip_subtitle),
            ),
          ],
        ),
      ),
    );
  }
}
