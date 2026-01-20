import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/core/app_text/app_text.dart';
import 'package:baby_look/shared/tips_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TipsForBestResult extends StatelessWidget {
  const TipsForBestResult({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.tr(AppText.tips_for_best_result), style: theme.textTheme.titleMedium,),
         SizedBox(height: AppConstant.appPadding,),
        TipsCard(
          iconBgColor: theme.colorScheme.onPrimary,
          iconColor: theme.colorScheme.primary,
       cardColor: theme.colorScheme.tertiaryFixed,
          icon: AppIcon.eyeIcon,
          title: context.tr(AppText.clear_profile_view),
          subtitle: context.tr(AppText.choose_an_image_showing_the_baby)
        ),
        TipsCard(
          iconBgColor: theme.colorScheme.onPrimary,
          iconColor: theme.colorScheme.primary,
            cardColor: theme.colorScheme.tertiaryFixed,
          icon: AppIcon.lightIcon,
          title: context.tr(AppText.good_lighting),
          subtitle: context.tr(AppText.ensure_ultrasound_image),
        ),
        TipsCard(
          iconBgColor: theme.colorScheme.onPrimary,
          iconColor: theme.colorScheme.primary,
          cardColor: theme.colorScheme.tertiaryFixed,
          icon: AppIcon.checkIcon,
          title: context.tr(AppText.recent_scan),
          subtitle: context.tr(AppText.use_your_most_recent_ultrasound),
        ),
      ],
    );
  }
}
