import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:baby_look/core/app_text/app_text.dart';
import 'package:baby_look/core/app_theme/app_color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FunFactsWidget extends StatelessWidget {
  const FunFactsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      //width: 250.0,
      height: 100,
      child: DefaultTextStyle(
        style: theme.textTheme.titleLarge!,
        child: AnimatedTextKit(
          pause: Duration.zero,
          repeatForever: true,
          animatedTexts: [
            FadeAnimatedText(context.tr(AppText.fact1)),
            FadeAnimatedText(context.tr(AppText.fact2)),
            FadeAnimatedText(context.tr(AppText.fact3)),
            FadeAnimatedText(context.tr(AppText.fact4)),
            FadeAnimatedText(context.tr(AppText.fact5)),
            FadeAnimatedText(context.tr(AppText.fact6)),
            FadeAnimatedText(context.tr(AppText.fact7)),
            FadeAnimatedText(context.tr(AppText.fact8)),
            FadeAnimatedText(context.tr(AppText.fact9)),
            FadeAnimatedText(context.tr(AppText.fact10)),
            FadeAnimatedText(context.tr(AppText.fact11)),
            FadeAnimatedText(context.tr(AppText.fact12)),
            FadeAnimatedText(context.tr(AppText.fact13)),
            FadeAnimatedText(context.tr(AppText.fact14)),
            FadeAnimatedText(context.tr(AppText.fact15)),
            FadeAnimatedText(context.tr(AppText.fact16)),
            FadeAnimatedText(context.tr(AppText.fact17)),
            FadeAnimatedText(context.tr(AppText.fact18)),
            FadeAnimatedText(context.tr(AppText.fact19)),
            FadeAnimatedText(context.tr(AppText.fact20)),
            FadeAnimatedText(context.tr(AppText.fact21)),
            FadeAnimatedText(context.tr(AppText.fact22)),
            FadeAnimatedText(context.tr(AppText.fact23)),
          ],
          onTap: () {
            print("Tap Event");
          },
        ),
      ),
    );
  }
}
