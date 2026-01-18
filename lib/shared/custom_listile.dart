import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/shared/custom_rounded_icon.dart';
import 'package:flutter/material.dart';

class CustomListile extends StatelessWidget {
  const CustomListile({
    super.key,
    this.title = 'Default',
    this.icon = Icons.add,
    this.tralingWidget = const Icon(AppIcon.arrowForwardIcon),
    this.onTap
  });

  final String title;
  final IconData icon;
  final Widget tralingWidget;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CustomRoundedIcon(icon: icon),
      title: Text(title),
      trailing: Transform.scale(scale: 0.8, child: tralingWidget),
    );
  }
}
