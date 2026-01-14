import 'package:baby_look/shared/custom_listile.dart';
import 'package:flutter/material.dart';

class LegalInfoWidget extends StatelessWidget {
  const LegalInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Legal'),
        CustomListile(title: 'Terms Of Service',),
        CustomListile(title: 'Pravicy Policy',),
        CustomListile(title: 'About AI BabyLook',),
      ],
    );
  }
}
