import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomRoundedIcon extends StatelessWidget {
  const CustomRoundedIcon({super.key, this.icon = Icons.add, this.color});
  final IconData icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(AppConstant.appPadding / 2),
      decoration: BoxDecoration(
        color: color ?? theme.indicatorColor ,
        borderRadius: BorderRadius.circular(AppConstant.borderRadius),
      ),
      child: Icon(icon),
    );
  }
}
