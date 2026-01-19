import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key, required this.value, this.onTap});
  final bool value;
 final  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: (value) {
        onTap;
      },
    );
  }
}
