import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  const BigButton({super.key, this.title = 'Default', this.onTap});

  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(border: Border.all()),
        child: Center(child: Text(title)),
      ),
    );
  }
}
