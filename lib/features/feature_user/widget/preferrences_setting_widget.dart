import 'package:baby_look/shared/custom_listile.dart';
import 'package:flutter/material.dart';

class PreferrencesSettingWidget extends StatelessWidget {
  const PreferrencesSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Preferences'),
        CustomListile(title: 'Notifications',),
        CustomListile(title: 'Language',),
        CustomListile(title: 'Help and FAQ',),
        CustomListile(title: 'Send Feedback',),
         CustomListile(title: 'Invite Friends',),

      ],
    );
  }
}
