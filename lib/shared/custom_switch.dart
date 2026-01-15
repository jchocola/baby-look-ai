import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Switch(value: true, onChanged: (value) {});
  }
}
