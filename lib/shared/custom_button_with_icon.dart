import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:flutter/material.dart';

class CustomButtonWithIcon extends StatelessWidget {
  const CustomButtonWithIcon({
    super.key,
    this.icon = Icons.add,
    this.title = "Default",
  });

  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppConstant.appPadding,
      children: [
        Icon(icon),
        Text(title),
      ],
    );
  }
}
