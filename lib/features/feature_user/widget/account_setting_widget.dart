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
        CustomListile(title: 'Edit Profile',),
        CustomListile(title: 'Subscription',),
        CustomListile(title: 'Prediction History',),

      ],
    );
  }
}
