import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_text/app_text.dart';
import 'package:baby_look/features/feature_generate/domain/prediction_entity.dart';
import 'package:baby_look/shared/custom_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FullScreenViewPage extends StatelessWidget {
  const FullScreenViewPage({super.key, this.prediction});
  final PredictionEntity? prediction;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.tr(AppText.view_full_image)),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Hero(
          tag: AppConstant.heroTag,
          child: Image.network(prediction?.photoUrl ?? AppConstant.defaultAvatarUrl))]);
  }
}
