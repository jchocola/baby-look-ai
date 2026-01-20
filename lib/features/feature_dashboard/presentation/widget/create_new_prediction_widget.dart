import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/core/app_text/app_text.dart';
import 'package:baby_look/core/app_theme/app_color.dart';
import 'package:baby_look/shared/custom_rounded_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CreateNewPredictionWidget extends StatelessWidget {
  const CreateNewPredictionWidget({super.key, this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppConstant.appPadding),
        decoration: BoxDecoration(
          border: Border.all(
            color: theme.colorScheme.primary
          ),
          color: theme.colorScheme.onPrimary,
          gradient: LinearGradient(colors: [
            theme.colorScheme.onPrimary,
            theme.colorScheme.onTertiary
          ]),
          borderRadius: BorderRadius.circular(AppConstant.borderRadius),
        ),
        width: double.infinity,
        height: size.height * 0.1,

        child: Row(
          spacing: AppConstant.appPadding,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomRoundedIcon(icon: AppIcon.createIcon, iconColor: theme.colorScheme.primary,),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(context.tr(AppText.create_new_prediction), style: theme.textTheme.titleLarge,maxLines: 1,),
                  Text(context.tr(AppText.upload_ultrasound_parent_photos),style: theme.textTheme.bodySmall,),
                ],
              ),
            ),
            Icon(AppIcon.arrowForwardIcon, color: theme.colorScheme.primary,),
          ],
        ),
      ),
    ).animate(
      onPlay: (controller) => controller.repeat(),
    ).shimmer(delay: 400.ms, duration: 1800.ms, color: theme.colorScheme.onPrimary).shake(hz: 0.5, curve: Curves.easeInOutCubic,).scaleXY(end: 1.1, duration: 600.ms).then(delay: 1000.ms).scaleXY(end:  1/1.1);
  }
}
