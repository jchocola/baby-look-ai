import 'package:flutter/material.dart';

class CustomCircleIcon extends StatelessWidget {
  const CustomCircleIcon({super.key, this.icon = Icons.add, this.bgColor = Colors.transparent});
  final IconData icon;
  final Color bgColor;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IconButton(
      color: bgColor,
     // highlightColor: bgColor,
      onPressed: () {}, icon: Icon(icon, color: theme.colorScheme.secondary,));
  }
}
