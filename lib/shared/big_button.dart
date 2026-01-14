import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  const BigButton({super.key, this.title = 'Default'});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      child: Center(child: Text(title)),
    );
  }
}
