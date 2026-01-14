import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/shared/custom_rounded_icon.dart';
import 'package:flutter/material.dart';

class TipsCard extends StatelessWidget {
  const TipsCard({
    super.key,
    this.icon = Icons.add,
    this.subtitle = 'Subtile',
    this.title = 'Title',
  });
  final String title;
  final String subtitle;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppConstant.appPadding),
        child: Row(
          spacing: AppConstant.appPadding,
          children: [
            CustomRoundedIcon(icon: icon),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: theme.textTheme.titleMedium, maxLines: 1,),
                  Text(subtitle, style: theme.textTheme.bodySmall, maxLines: 2,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
