import 'package:baby_look/shared/custom_app_bar.dart';
import 'package:flutter/material.dart';

class PredictionDetailPage extends StatelessWidget {
  const PredictionDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Prediction Details',),
    );
  }
}
