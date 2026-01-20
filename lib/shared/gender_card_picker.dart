import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_theme/app_color.dart';
import 'package:flutter/material.dart';

class GenderCardPicker extends StatelessWidget {
  const GenderCardPicker({
    super.key,
    this.icon = Icons.add,
    this.title = 'Default',
    this.isSelected = false,
    this.onTap
  });
  final String title;
  final IconData icon;
  final bool isSelected;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final showColor = isSelected
        ? theme.colorScheme.primary
        : theme.colorScheme.secondary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
       // padding: EdgeInsets.all(AppConstant.appPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstant.borderRadius),
          border: Border.all(color: showColor),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: showColor),
              Text(
                title,
                style: theme.textTheme.titleSmall!.copyWith(color: showColor),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
