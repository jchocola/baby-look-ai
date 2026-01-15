import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/shared/custom_listile.dart';
import 'package:flutter/material.dart';

class AccountSettingWidget extends StatelessWidget {
  const AccountSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Account'),
        CustomListile(title: 'Edit Profile',icon: AppIcon.editProfileIcon,),
        CustomListile(title: 'Subscription', icon: AppIcon.subscriptionIcon,),
        CustomListile(title: 'Prediction History',icon: AppIcon.predictionHistoryIcon,),

      ],
    );
  }
}
