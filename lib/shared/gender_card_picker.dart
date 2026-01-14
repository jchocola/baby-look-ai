import 'package:baby_look/core/app_theme/app_color.dart';
import 'package:flutter/material.dart';

class GenderCardPicker extends StatelessWidget {
  const GenderCardPicker({super.key, this.icon = Icons.add, this.title = 'Default'});
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(color: AppColor.yellowColor2, child: Center(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        Text(title),
      ],
    )));
  }
}
