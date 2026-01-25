import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_enum/baby_gender.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/core/app_text/app_text.dart';
import 'package:baby_look/core/toastification/show_success_custom_toastification.dart';
import 'package:baby_look/features/feature_gallery/bloc/predictions_bloc.dart';
import 'package:baby_look/features/feature_gallery/widget/generated_image_card.dart';
import 'package:baby_look/features/feature_generate/domain/prediction_entity.dart';
import 'package:baby_look/shared/big_button.dart';
import 'package:baby_look/shared/custom_app_bar.dart';
import 'package:baby_look/shared/tips_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PredictionDetailPage extends StatelessWidget {
  const PredictionDetailPage({super.key, this.prediction});
  final PredictionEntity? prediction;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.tr(AppText.prediction_details)),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstant.appPadding,
        vertical: AppConstant.appPadding / 2,
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: AppConstant.appPadding,
          children: [
            Hero(
              tag: AppConstant.heroTag,
              child: GeneratedImageCard(
                onTap: () {
                  context.go('/gallery/fullscreen_view', extra: prediction);
                },
                imageUrl: prediction?.photoUrl,
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: TipsCard(
                    iconBgColor: theme.colorScheme.onPrimary,
                    iconColor: theme.colorScheme.primary,
                    cardColor: theme.colorScheme.tertiaryFixed,
                    icon: AppIcon.calendarIcon,
                    title: context.tr(AppText.gestation),
                    subtitle: context.tr(
                      AppText.week_n,
                      args: [prediction?.gestationWeek.toString() ?? ''],
                    ),
                  ),
                ),
                Expanded(
                  child: TipsCard(
                    iconBgColor: theme.colorScheme.onPrimary,
                    iconColor: theme.colorScheme.primary,
                    cardColor: theme.colorScheme.tertiaryFixed,
                    icon: AppIcon.genderIcon,
                    title: context.tr(AppText.gender),
                    subtitle: genderToStr(
                      context,
                      gender: context.tr(AppText.boy),
                    ),
                  ),
                ),
              ],
            ),
            TipsCard(
              iconBgColor: theme.colorScheme.onPrimary,
              iconColor: theme.colorScheme.primary,
              cardColor: theme.colorScheme.tertiaryFixed,
              icon: AppIcon.dateIcon,
              title: context.tr(AppText.date),
              subtitle: prediction?.created.toLocal().toString() ?? '',
            ),
            BigButton(
              title: context.tr(AppText.view_full_image),
              borderColor: theme.colorScheme.primary,
              buttonColor: theme.colorScheme.onPrimary,
              icon: Icon(AppIcon.fullImageIcon),
              onTap: () {
                context.go('/gallery/fullscreen_view', extra: prediction);
              },
            ),
            BigButton(
              title: context.tr(AppText.share_prediction),
              borderColor: theme.colorScheme.tertiary,
              buttonColor: theme.colorScheme.tertiaryFixed,
              icon: Icon(AppIcon.shareIcon),
              onTap: () => context.read<PredictionsBloc>().add(
                PredictionsBlocEvent_shareImageFromServerToGallery(
                  prediction: prediction,
                  content: context.tr(AppText.share_content),
                ),
              ),
            ),
            BlocListener<PredictionsBloc, PredictionsBlocState>(
              listener: (context, state) {
                if (state is PredictionsBlocState_success) {
                  showSuccessCustomToastification(title: state.success);
                }
              },
              child: BigButton(
                title: context.tr(AppText.save_to_gallery),
                borderColor: theme.colorScheme.error,
                buttonColor: theme.colorScheme.errorContainer,
                icon: Icon(AppIcon.galleryIcon),
                onTap: () => context.read<PredictionsBloc>().add(
                  PredictionsBlocEvent_saveImageFromServerToGallery(
                    prediction: prediction,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
