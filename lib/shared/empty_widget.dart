import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/shared/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LottieBuilder.asset('assets/empty_case.json'),
        Text('Тут ничего нет...')
      ],
    );
  }
}
