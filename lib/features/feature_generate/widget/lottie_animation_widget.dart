import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimationWidget extends StatelessWidget {
  const LottieAnimationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/generating.json');
  }
}
