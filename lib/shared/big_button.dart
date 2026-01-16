import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  const BigButton({
    super.key,
    this.title = 'Default',
    this.onTap,
    this.buttonColor = Colors.transparent,
    this.borderColor = Colors.transparent,
    this.icon
  });

  final String title;
  final void Function()? onTap;
  final Color buttonColor;
  final Color borderColor;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppConstant.appPadding),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          color: buttonColor,
          borderRadius: BorderRadius.circular(AppConstant.borderRadius),
        ),
        child: Center(child: Row(
        
          mainAxisSize: MainAxisSize.min,
          children: [
            icon ?? SizedBox(),
            icon != null ? SizedBox(width: AppConstant.appPadding,) : SizedBox(),
            Text(title, style: theme.textTheme.titleMedium),
          ],
        )),
      ),
    );
  }
}
