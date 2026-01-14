import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/shared/custom_rounded_icon.dart';
import 'package:flutter/material.dart';

class CustomListile extends StatelessWidget {
  const CustomListile({super.key, this.title = 'Default'});

  final String title;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomRoundedIcon(),
      title: Text(title),
    trailing: Icon(AppIcon.arrowForwardIcon),
      );
  }
}
