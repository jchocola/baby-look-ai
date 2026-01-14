import 'package:flutter/material.dart';

class CustomRoundedIcon extends StatelessWidget {
  const CustomRoundedIcon({super.key, this.icon = Icons.add});
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Icon(icon);
  }
}
