import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.title = 'Default'});
  final String title;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      title: Text(title, style: theme.textTheme.titleMedium),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppConstant.preferredSizeHeight);
}
