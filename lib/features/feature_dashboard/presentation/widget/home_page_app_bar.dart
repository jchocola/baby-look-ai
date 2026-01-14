import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/shared/custom_circle_avatar.dart';
import 'package:flutter/material.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text('Welcome back,', style: theme.textTheme.bodySmall,), Text('Expecting Parent!',style: theme.textTheme.titleMedium)],
      ),

    actions: [
      IconButton(onPressed: (){}, icon: Icon(AppIcon.notificationIcon)),
     CustomCircleAvatar(),
    ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppConstant.preferredSizeHeight);
}
