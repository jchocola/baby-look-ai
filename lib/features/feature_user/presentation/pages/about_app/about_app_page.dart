import 'dart:math';

import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/core/app_text/app_text.dart';
import 'package:baby_look/shared/app_logo.dart';
import 'package:baby_look/shared/custom_app_bar.dart';
import 'package:baby_look/shared/custom_listile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.tr(AppText.about_us)),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppLogo().animate(
            onPlay: (controller) {
              controller.repeat(reverse: true);
            },
          ).scaleXY(end: 1.5, duration: 1000.ms).then(delay: 300.ms). scaleXY(end: 1.2, duration: 300.ms, delay: 300.ms).shake(duration: 600.ms ,delay: 200.ms ),
          SizedBox(height: AppConstant.appPadding * 2,),
          CustomListile(
            icon: AppIcon.versionIcon,
            title:  context.tr(AppText.version),
            tralingWidget: Text('1.0.0', style: theme.textTheme.titleMedium),
          ),
          CustomListile(
            icon: AppIcon.buildDateIcon,
            title:  context.tr(AppText.build_date),
            tralingWidget: Text('1.0.0', style: theme.textTheme.titleMedium),
          ),
          CustomListile(
            icon: AppIcon.developerIcon,
            title:  context.tr(AppText.developer),
            tralingWidget: Text(
              'Nguen T.B',
              style: theme.textTheme.titleMedium,
            ),
          ),
          CustomListile(
            icon: AppIcon.AIIcon, 
            title:  context.tr(AppText.ai_model),
            tralingWidget: Text(
              'Nano Banana Pro',
              style: theme.textTheme.titleMedium,
            ),
          ),
          CustomListile(
            icon: AppIcon.techStackIcon,
            title:  context.tr(AppText.tech_stack),
            tralingWidget: Text(
              'Flutter/Dart',
              style: theme.textTheme.titleMedium,
            ),
          ),
          CustomListile(
            icon: AppIcon.emailIcon,
            title:  context.tr(AppText.contact),
            tralingWidget: Text(
              'egmail.com',
              style: theme.textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
