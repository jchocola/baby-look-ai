import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_text/app_text.dart';
import 'package:baby_look/core/utils/language_converter.dart';
import 'package:baby_look/shared/custom_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguagesModal extends StatelessWidget {
  const LanguagesModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.tr(AppText.language)),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
      child: Column(
        children: List.generate(context.supportedLocales.length, (index) {
          final Locale locale = context.supportedLocales[index];
          final currentLocale = context.locale;
          return _languageListTile(
            locale: locale,
            isCurrent: currentLocale == locale,
            onTap: () {
              context.setLocale(locale);
            },
          );
        }),
      ),
    );
  }
}

class _languageListTile extends StatelessWidget {
  const _languageListTile({
    super.key,
    required this.locale,
    this.isCurrent = false,
    this.onTap,
  });
  final Locale locale;
  final bool isCurrent;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: isCurrent ? theme.colorScheme.onTertiary : null,
      child: ListTile(onTap: onTap, title: Text(languageConverter(locale))),
    );
  }
}
