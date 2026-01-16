import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/core/app_theme/app_color.dart';
import 'package:baby_look/shared/custom_rounded_icon.dart';
import 'package:flutter/material.dart';

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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Create New Prediction', style: theme.textTheme.titleLarge,),
                Text('Upload ultrasound and parent photos',style: theme.textTheme.bodySmall,),
              ],
            ),
            Icon(AppIcon.arrowForwardIcon, color: theme.colorScheme.primary,),
          ],
        ),
      ),
    );
  }
}
