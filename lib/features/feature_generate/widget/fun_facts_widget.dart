import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:baby_look/core/app_theme/app_color.dart';
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
            FadeAnimatedText(
              "70% вероятности - ребенок унаследует форму губ от матери",
            ),
            FadeAnimatedText(
              "60% шанс получить ямочки на щеках, если они есть у одного родителя",
            ),
            FadeAnimatedText(
              "90% вероятности унаследовать форму носа от одного из родителей",
            ),
            FadeAnimatedText("75% детей перенимают цвет волос от отца"),
            FadeAnimatedText(
              '80% случаев - карие глаза побеждают голубые (доминантный ген)',
            ),
            FadeAnimatedText(
              '90% вероятности - вьющиеся волосы доминируют над прямыми',
            ),
            FadeAnimatedText(
              '85% шанс - ямочка на подбородке передастся от отца к сыну',
            ),
            FadeAnimatedText('70% детей наследуют форму бровей от матери'),
            FadeAnimatedText(
              "1 из 4 детей рождаются похожими на бабушку или дедушку, минуя родителей",
            ),
            FadeAnimatedText(
              "30% малышей наследуют улыбку от отца, даже если похожи на мать",
            ),
            FadeAnimatedText(
              "20% случаев - ребенок получает комбинацию черт, которой нет ни у одного родителя",
            ),
            FadeAnimatedText(
              "10% детей рождаются с точной копией родинки в том же месте, что у родителя",
            ),
            FadeAnimatedText("70% сыновей наследуют форму лица от матери"),
            FadeAnimatedText('80% дочерей перенимают текстуру волос от отца'),
            FadeAnimatedText('60% мальчиков получают цвет глаз матери'),
            FadeAnimatedText('90% девочек наследуют форму ушей от отца'),
            FadeAnimatedText(
              '50% вероятности - первый ребенок будет похож на отца, второй - на мать',
            ),
            FadeAnimatedText('55% черт лица передаются по наследству'),
            FadeAnimatedText(
              '3 поколения - максимальная "память" генов о внешности предков',
            ),
             FadeAnimatedText(
              '1 из 10 пар рождает ребенка, который не похож ни на одного из них',
            ),
             FadeAnimatedText(
              '85% родителей находят в ребенке свои черты, даже если их нет',
            ),
             FadeAnimatedText(
              '70% бабушек утверждают, что внук похож на их сторону семьи',
            ),
             FadeAnimatedText(
              '60% отцов видят в сыне свое "отражение в миниатюре"',
            ),

          ],
          onTap: () {
            print("Tap Event");
          },
        ),
      ),
    );
  }
}
