import 'package:flutter/material.dart';

class CopyrightWidget extends StatelessWidget {
  const CopyrightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('BabyLook v1.0.0'),
        Text('© 2025 BabyLook. All rights reserved.')
      ],
    );
  }
}
