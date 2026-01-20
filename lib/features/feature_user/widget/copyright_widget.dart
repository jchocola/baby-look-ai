import 'package:baby_look/core/app_text/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CopyrightWidget extends StatelessWidget {
  const CopyrightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(context.tr(AppText.app_version), style: theme.textTheme.bodySmall),
        Text(context.tr(AppText.copyright), style: theme.textTheme.bodySmall),
      ],
    );
  }
}
