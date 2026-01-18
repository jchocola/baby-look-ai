import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/features/feature_gallery/widget/generated_image_card.dart';
import 'package:baby_look/shared/big_button.dart';
import 'package:baby_look/shared/custom_app_bar.dart';
import 'package:baby_look/shared/tips_card.dart';
import 'package:flutter/material.dart';

class PredictionDetailPage extends StatelessWidget {
  const PredictionDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Prediction Details'),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstant.appPadding,
        vertical: AppConstant.appPadding / 2,
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: AppConstant.appPadding,
          children: [
            Hero(tag: AppConstant.heroTag, child: GeneratedImageCard()),
        
            Row(
              children: [
                Expanded(
                  child: TipsCard(
                    iconBgColor: theme.colorScheme.onPrimary,
                    iconColor: theme.colorScheme.primary,
                    cardColor: theme.colorScheme.tertiaryFixed,
                    icon: AppIcon.calendarIcon,
                    title: "Gestation",
                    subtitle: "Week 12",
                  ),
                ),
                Expanded(
                  child: TipsCard(
                    iconBgColor: theme.colorScheme.onPrimary,
                    iconColor: theme.colorScheme.primary,
                    cardColor: theme.colorScheme.tertiaryFixed,
                    icon: AppIcon.genderIcon,
                    title: "Gender",
                    subtitle: "Unknown",
                  ),
                ),
              ],
            ),
            TipsCard(
              iconBgColor: theme.colorScheme.onPrimary,
              iconColor: theme.colorScheme.primary,
              cardColor: theme.colorScheme.tertiaryFixed,
              icon: AppIcon.dateIcon,
              title: "Date",
              subtitle: "Nov 1, 2025",
            ),
            BigButton(
              title: 'View Full Image',
              borderColor: theme.colorScheme.primary,
              buttonColor: theme.colorScheme.onPrimary,
              icon: Icon(AppIcon.fullImageIcon),
            ),
            BigButton(
              title: "Share Prediction",
              borderColor: theme.colorScheme.tertiary,
              buttonColor: theme.colorScheme.tertiaryFixed,
              icon: Icon(AppIcon.shareIcon),
            ),
              BigButton(
              title: "Save to Gallery",
              borderColor: theme.colorScheme.tertiary,
              buttonColor: theme.colorScheme.tertiaryFixed,
              icon: Icon(AppIcon.shareIcon),
            ),
            BigButton(title: 'Back to Gallery'),
          ],
        ),
      ),
    );
  }
}
