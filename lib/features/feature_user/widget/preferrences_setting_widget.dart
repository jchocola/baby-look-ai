import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/shared/custom_listile.dart';
import 'package:baby_look/shared/custom_switch.dart';
import 'package:flutter/material.dart';

class PreferrencesSettingWidget extends StatelessWidget {
  const PreferrencesSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Preferences',  style: theme.textTheme.titleMedium,),
        CustomListile(title: 'Notifications', icon: AppIcon.notificationIcon, tralingWidget: CustomSwitch(),),
        CustomListile(title: 'Language', icon: AppIcon.languageIcon,),
        CustomListile(title: 'Help and FAQ', icon: AppIcon.helpIcon,),
        CustomListile(title: 'Send Feedback', icon: AppIcon.feedbackIcon,) ,
        // CustomListile(title: 'Invite Friends',),

      ],
    );
  }
}
