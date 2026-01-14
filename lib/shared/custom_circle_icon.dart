import 'package:flutter/material.dart';

class CustomCircleIcon extends StatelessWidget {
  const CustomCircleIcon({super.key, this.icon = Icons.add});
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () {}, icon: Icon(icon));
  }
}
