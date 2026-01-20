import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_text/app_text.dart';
import 'package:baby_look/shared/custom_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HelpFaqPage extends StatelessWidget {
  const HelpFaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.tr(AppText.help_faq)),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    final QAs = [
      {"q": context.tr(AppText.faq_q1), "a": context.tr(AppText.faq_a1)},
      {"q": context.tr(AppText.faq_q2), "a": context.tr(AppText.faq_a2)},
      {"q": context.tr(AppText.faq_q3), "a": context.tr(AppText.faq_a3)},
      {"q": context.tr(AppText.faq_q4), "a": context.tr(AppText.faq_a4)},
      {"q": context.tr(AppText.faq_q5), "a": context.tr(AppText.faq_a5)},
      {"q": context.tr(AppText.faq_q6), "a": context.tr(AppText.faq_a6)},
      {"q": context.tr(AppText.faq_q7), "a": context.tr(AppText.faq_a7)},
      {"q": context.tr(AppText.faq_q8), "a": context.tr(AppText.faq_a8)},
      {"q": context.tr(AppText.faq_q9), "a": context.tr(AppText.faq_a9)},
      {"q": context.tr(AppText.faq_q10), "a": context.tr(AppText.faq_a10)},
      {"q": context.tr(AppText.faq_q11), "a": context.tr(AppText.faq_a11)},
      {"q": context.tr(AppText.faq_q12), "a": context.tr(AppText.faq_a12)},
      {"q": context.tr(AppText.faq_q13), "a": context.tr(AppText.faq_a13)},
      {"q": context.tr(AppText.faq_q14), "a": context.tr(AppText.faq_a14)},
      {"q": context.tr(AppText.faq_q15), "a": context.tr(AppText.faq_a15)},
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(QAs.length, (index) {
            final qa = QAs[index];
            return ExpansionTile(
              title: Text("${index + 1}) ${qa["q"]}"),
              children: [Text(qa["a"] as String)],
            );
          }),
        ),
      ),
    );
  }
}
