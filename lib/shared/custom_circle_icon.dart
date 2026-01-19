import 'package:flutter/material.dart';

class CustomCircleIcon extends StatelessWidget {
  const CustomCircleIcon({
    super.key,
    this.icon = Icons.add,
    this.bgColor = Colors.transparent,
    this.onPressed,
    this.iconColor = Colors.black54
  });
  final IconData icon;
  final Color bgColor;
  final void Function()? onPressed;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IconButton(
      color: bgColor,
      // highlightColor: bgColor,
      onPressed: onPressed,
      icon: Icon(icon, color: iconColor),
    );
  }
}
