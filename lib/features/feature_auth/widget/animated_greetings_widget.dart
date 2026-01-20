import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:baby_look/core/app_text/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AnimatedGreetingsWidget extends StatelessWidget {
  const AnimatedGreetingsWidget({super.key});

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
            FadeAnimatedText(context.tr(AppText.greeting1)),
            FadeAnimatedText(context.tr(AppText.greeting2)),
            FadeAnimatedText(context.tr(AppText.greeting3)),
            FadeAnimatedText(
              context.tr(AppText.greeting4),
            ),
            FadeAnimatedText(context.tr(AppText.greeting5)),
          ],
          onTap: () {
            print("Tap Event");
          },
        ),
      ),
    );
  }
}
