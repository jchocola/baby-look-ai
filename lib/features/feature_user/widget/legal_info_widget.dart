import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/shared/custom_listile.dart';
import 'package:flutter/material.dart';

class LegalInfoWidget extends StatelessWidget {
  const LegalInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Legal' ,style: theme.textTheme.titleMedium),
        CustomListile(title: 'Terms Of Service', icon: AppIcon.termServiceIcon,),
        CustomListile(title: 'Pravicy Policy', icon: AppIcon.pravicyPolicyIcon,),
        CustomListile(title: 'About AI BabyLook', icon: AppIcon.infoIcon,),
      ],
    );
  }
}
