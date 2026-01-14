import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/shared/tips_card.dart';
import 'package:flutter/material.dart';

class TipsForBestResult extends StatelessWidget {
  const TipsForBestResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Tips for Best Results'),
        TipsCard(icon: AppIcon.eyeIcon, title: "Clear Profile View", subtitle: "Choose an image showing the baby's profile clearly",),
        TipsCard(icon: AppIcon.lightIcon, title: "Good Lighting",subtitle: "Ensure the ultrasound image is well-lit and not blurry",),
        TipsCard(icon: AppIcon.checkIcon, title: "Recent Scan",subtitle: "Use your most recent ultrasound for best accuracy",)
      ],
    );
  }
}
