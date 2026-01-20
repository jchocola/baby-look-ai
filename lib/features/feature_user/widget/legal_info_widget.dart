import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/core/app_text/app_text.dart';
import 'package:baby_look/core/utils/lauch_to_url.dart';
import 'package:baby_look/shared/custom_listile.dart';
import 'package:easy_localization/easy_localization.dart';
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
        Text(context.tr(AppText.legal_info), style: theme.textTheme.titleMedium),
        CustomListile(
          title: context.tr(AppText.terms_of_services),
          icon: AppIcon.termServiceIcon,
          onTap: () async {
            await lauch_to_url(url: AppConstant.termServiceUrl);
          },
        ),
        CustomListile(title: context.tr(AppText.pravicy_policy), icon: AppIcon.pravicyPolicyIcon,  onTap: () async {
            await lauch_to_url(url: AppConstant.privacyPolicyUrl);
          },),
        CustomListile(
          title: context.tr(AppText.about_us),
          icon: AppIcon.infoIcon,
          onTap: () {
            context.go('/user/about');
          },
        ),
      ],
    );
  }
}
