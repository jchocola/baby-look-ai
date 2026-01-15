import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_theme/app_color.dart';
import 'package:baby_look/shared/custom_rounded_icon.dart';
import 'package:flutter/material.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({
    super.key,
    this.note = 'Default',
    this.color = Colors.blueAccent,
    this.icon = Icons.info_rounded,
  });
  final String note;
  final Color color;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstant.borderRadius),
        border: Border.all(color: color.withOpacity(0.6)),
      ),

      padding: EdgeInsets.all(AppConstant.appPadding),
      child: Row(
        spacing: AppConstant.appPadding,
        children: [
          CustomRoundedIcon(icon: icon, iconColor: color),
          Flexible(child: Text(note, style: theme.textTheme.bodyMedium,)),
        ],
      ),
    );
  }
}
