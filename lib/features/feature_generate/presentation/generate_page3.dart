import 'dart:io';

import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_exception/app_exception.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/core/app_text/app_text.dart';
import 'package:baby_look/core/toastification/show_error_custom_toastification.dart';
import 'package:baby_look/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:baby_look/features/feature_generate/bloc/generating_bloc.dart';
import 'package:baby_look/features/feature_generate/bloc/prepare_data_bloc.dart';
import 'package:baby_look/features/feature_generate/widget/baby_gender_picker.dart';
import 'package:baby_look/features/feature_generate/widget/gestation_week.dart';
import 'package:baby_look/features/feature_generate/widget/tips_for_best_result.dart';
import 'package:baby_look/features/feature_generate/widget/upload_parent_photo.dart';
import 'package:baby_look/features/feature_generate/widget/upload_ultrasound_widget.dart';
import 'package:baby_look/shared/big_button.dart';
import 'package:baby_look/shared/custom_app_bar.dart';
import 'package:baby_look/shared/custom_button_with_icon.dart';
import 'package:baby_look/shared/note_widget.dart';
import 'package:baby_look/shared/picked_image_card.dart';
import 'package:baby_look/shared/tips_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeneratePage3 extends StatelessWidget {
  const GeneratePage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.tr(AppText.step3_appbar) ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(AppConstant.appPadding),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppConstant.appPadding,
          children: [
            Text(context.tr(AppText.upload_parent_photo), style: theme.textTheme.titleMedium),
            Text(
             context.tr(AppText.upload_parent_photo_note),
              style: theme.textTheme.bodySmall,
            ),

            Row(
              children: [
                Expanded(
                  child: TipsCard(
                    iconBgColor: theme.colorScheme.onPrimary,
                    iconColor: theme.colorScheme.primary,
                    cardColor: theme.colorScheme.tertiaryFixed,
                    icon: AppIcon.ideaIcon,
                    title: context.tr(AppText.good_lighting),
                    subtitle:
                        context.tr(AppText.use_natural_light),
                  ),
                ),
                Expanded(
                  child: TipsCard(
                    iconBgColor: theme.colorScheme.onPrimary,
                    iconColor: theme.colorScheme.primary,
                    cardColor: theme.colorScheme.tertiaryFixed,
                    icon: AppIcon.clearFaceIcon,
                    title: context.tr(AppText.clear_face),
                    subtitle: context.tr(AppText.ensure_face),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: TipsCard(
                    iconBgColor: theme.colorScheme.onPrimary,
                    iconColor: theme.colorScheme.primary,
                    cardColor: theme.colorScheme.tertiaryFixed,
                    icon: AppIcon.faceFillIcon,
                    title: context.tr(AppText.face_fills_frame),
                    subtitle: context.tr(AppText.position_face_to_fill),
                  ),
                ),
                Expanded(
                  child: TipsCard(
                    iconBgColor: theme.colorScheme.onPrimary,
                    iconColor: theme.colorScheme.primary,
                    cardColor: theme.colorScheme.tertiaryFixed,
                    icon: AppIcon.naturalIcon,
                    title: context.tr(AppText.natural_expression),
                    subtitle: context.tr(AppText.natural_expression_note),
                  ),
                ),
              ],
            ),

            NoteWidget(
              color: theme.colorScheme.error,
              icon: AppIcon.infoIcon,
              note:
                 context.tr(AppText.step3_tip),
            ),

            ///
            /// MOTHER
            ///
            BlocBuilder<PrepareDataBloc, PrepareDataBlocState>(
              builder: (context, state) => UploadParentPhotoCard(
                bgColor: theme.colorScheme.onPrimary,
                icon: AppIcon.motherIcon,
                title: context.tr(AppText.mother_photo),
                subtitle:context.tr(AppText.clear_frontal_photo_for_best_result),
                onTapCameraTapped: () => context.read<PrepareDataBloc>().add(
                  PrepareDataBlocEvent_pickMotherImageFromCamera(),
                ),
                pickedImage:
                    state is PrepareDataBlocState_loaded &&
                        state.motherImage != null
                    ? PickedImageCard(file: File(state.motherImage!.path), onCancelPressed: () => context.read<PrepareDataBloc>().add(PrepareDataBlocEvent_cancelMotherImage()),)
                    : null,
                onGalleryTapped: () => context.read<PrepareDataBloc>().add(
                  PrepareDataBlocEvent_pickMotherImageFromGallery(),
                ),
              ),
            ),

            ///
            /// FATHER
            ///
            BlocBuilder<PrepareDataBloc, PrepareDataBlocState>(
              builder: (context, state) => UploadParentPhotoCard(
                bgColor: theme.colorScheme.tertiaryFixed,
                icon: AppIcon.fatherIcon,
                title: context.tr(AppText.father_photo),
                subtitle: context.tr(AppText.clear_frontal_photo_for_best_result),
                pickedImage:
                    state is PrepareDataBlocState_loaded &&
                        state.fatherImage != null
                    ? PickedImageCard(file: File(state.fatherImage!.path), onCancelPressed: () => context.read<PrepareDataBloc>().add(PrepareDataBlocEvent_cancelFatherImage()),)
                    : null,
                onGalleryTapped: () => context.read<PrepareDataBloc>().add(
                  PrepareDataBlocEvent_pickFatherImageFromGallery(),
                ),

                onTapCameraTapped: () => context.read<PrepareDataBloc>().add(
                  PrepareDataBlocEvent_pickFatherImageFromCamera(),
                ),
              ),
            ),

            ///
            /// BUTTONS
            ///
            BlocBuilder<AuthBloc, AuthBlocState>(
              builder: (context, authState) =>
                  BlocBuilder<PrepareDataBloc, PrepareDataBlocState>(
                    builder: (context, state) =>
                        BigButton(
                              buttonColor: theme.colorScheme.onPrimary,
                              borderColor: theme.colorScheme.primary,
                              title: context.tr(AppText.generate_prediction),
                              onTap: () {
                                if (state is PrepareDataBlocState_loaded) {
                                  context.read<GeneratingBloc>().add(
                                    GeneratingBlocEvent_generatePrediction(
                                      ultrasoundImage: File(
                                        state.ultrasoundImage!.path,
                                      ),
                                      gestationWeek: state.gestationWeek ?? 1,
                                      motherImage: File(
                                        state.motherImage!.path,
                                      ),
                                      fatherImage: File(
                                        state.fatherImage!.path,
                                      ),
                                      gender: state.babyGender.name,
                                      user:
                                          authState
                                              is AuthBlocState_authenticated
                                          ? authState.user
                                          : null,
                                    ),
                                  );
                                }
                              },
                            )
                            .animate(
                              onPlay: (controller) => controller.repeat(),
                            )
                            .shimmer(
                              duration: 2000.ms,
                              delay: 1800.ms,
                              color: theme.colorScheme.onPrimary,
                            )
                            .then(delay: 400.ms),
                  ),
            ),
            BigButton(
              borderColor: theme.colorScheme.error,
              buttonColor: theme.colorScheme.errorContainer,

              title: context.tr(AppText.cancel),
              onTap: () => context.read<PrepareDataBloc>().add(
                PrepareDataBlocEvent_cancelAll(),
              ),
            ),

            Text(
              context.tr(AppText.step3_note),
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
