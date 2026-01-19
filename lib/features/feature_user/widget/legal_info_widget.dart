import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/core/utils/lauch_to_url.dart';
import 'package:baby_look/shared/custom_listile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LegalInfoWidget extends StatelessWidget {
  const LegalInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Legal', style: theme.textTheme.titleMedium),
        CustomListile(
          title: 'Terms Of Service',
          icon: AppIcon.termServiceIcon,
          onTap: () async {
            await lauch_to_url(url: AppConstant.termServiceUrl);
          },
        ),
        CustomListile(title: 'Pravicy Policy', icon: AppIcon.pravicyPolicyIcon,  onTap: () async {
            await lauch_to_url(url: AppConstant.privacyPolicyUrl);
          },),
        CustomListile(
          title: 'About AI BabyLook',
          icon: AppIcon.infoIcon,
          onTap: () {
            context.go('/user/about');
          },
        ),
      ],
    );
  }
}
