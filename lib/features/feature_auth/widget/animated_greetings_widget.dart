import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:baby_look/core/app_theme/app_color.dart';
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
            FadeAnimatedText('Добро пожаловать в волшебный мир ожидания!'),
            FadeAnimatedText('Скоро вы увидите самое прекрасное лицо на свете'),
            FadeAnimatedText('За каждой улыбкой малыша - история любви'),
            FadeAnimatedText(
              'Место, где мечты родителей становятся реальностью',
            ),
            FadeAnimatedText('Первая встреча с вашим чудом начинается здесь'),
          ],
          onTap: () {
            print("Tap Event");
          },
        ),
      ),
    );
  }
}
