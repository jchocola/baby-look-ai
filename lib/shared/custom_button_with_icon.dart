import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:flutter/material.dart';

class CustomButtonWithIcon extends StatelessWidget {
  const CustomButtonWithIcon({
    super.key,
    this.icon = Icons.add,
    this.title = "Default",
    this.onTap,
    this.iconColor = Colors.black54,
  });

  final String title;
  final IconData icon;
  final Color iconColor;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.4,
        padding: EdgeInsets.symmetric(
          horizontal: AppConstant.appPadding,
          vertical: AppConstant.appPadding / 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstant.borderRadius),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppConstant.appPadding,
          children: [
            Icon(icon, color: iconColor),
            Text(title, style: theme.textTheme.titleSmall,),
          ],
        ),
      ),
    );
  }
}
