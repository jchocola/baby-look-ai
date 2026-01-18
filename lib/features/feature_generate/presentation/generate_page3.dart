import 'dart:io';

import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeneratePage3 extends StatelessWidget {
  const GeneratePage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Step3: Parent Photos (Required)'),
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
            Text('Upload Parent Photos', style: theme.textTheme.titleMedium),
            Text(
              "Clear photos of both parents help our AI generate a more accurate baby prediction",
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
                    title: "Good Lighting",
                    subtitle:
                        "Use natural light or well-lit indoor environment",
                  ),
                ),
                Expanded(
                  child: TipsCard(
                    iconBgColor: theme.colorScheme.onPrimary,
                    iconColor: theme.colorScheme.primary,
                    cardColor: theme.colorScheme.tertiaryFixed,
                    icon: AppIcon.clearFaceIcon,
                    title: "Clear Face",
                    subtitle: "Ensure face is clearly visible and in focus",
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
                    title: "Face Fills Frame",
                    subtitle: "Position face to fill most of the frame",
                  ),
                ),
                Expanded(
                  child: TipsCard(
                    iconBgColor: theme.colorScheme.onPrimary,
                    iconColor: theme.colorScheme.primary,
                    cardColor: theme.colorScheme.tertiaryFixed,
                    icon: AppIcon.naturalIcon,
                    title: "Natural Expression",
                    subtitle: "Neutral or natural expression works best",
                  ),
                ),
              ],
            ),

            NoteWidget(
              color: theme.colorScheme.error,
              icon: AppIcon.infoIcon,
              note:
                  "Tip ! Frontal photos with neutral backgrounds work best for accurate predictions",
            ),

            ///
            /// MOTHER
            ///
            BlocBuilder<PrepareDataBloc, PrepareDataBlocState>(
              builder: (context, state) => UploadParentPhotoCard(
                title: "Mother's Photo",
                subtitle: "Clear frontal photo for best results",
                onTapCameraTapped: () => context.read<PrepareDataBloc>().add(
                  PrepareDataBlocEvent_pickMotherImageFromCamera(),
                ),
                pickedImage:
                    state is PrepareDataBlocState_loaded &&
                        state.motherImage != null
                    ? PickedImageCard(file: File(state.motherImage!.path))
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
                title: "Father's Photo",
                subtitle: "Clear frontal photo for best results",
                pickedImage:
                    state is PrepareDataBlocState_loaded &&
                        state.fatherImage != null
                    ? PickedImageCard(file: File(state.fatherImage!.path))
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
            BlocBuilder<AuthBloc,AuthBlocState>(
              builder:(context,authState)=> BlocBuilder<PrepareDataBloc, PrepareDataBlocState>(
                builder: (context, state) => BigButton(
                  buttonColor: theme.colorScheme.onPrimary,
                  borderColor:theme.colorScheme.primary,
                  title: 'Generate Prediction',
                  onTap: () {
                    if (state is PrepareDataBlocState_loaded) {
                      context.read<GeneratingBloc>().add(
                        GeneratingBlocEvent_generatePrediction(
                          ultrasoundImage: File(state.ultrasoundImage!.path),
                          gestationWeek: state.gestationWeek ?? 1,
                          motherImage: File(state.motherImage!.path),
                          fatherImage: File(state.fatherImage!.path),
                          gender: state.babyGender.name,
                          user: authState is AuthBlocState_authenticated ? authState.user : null
                        ),
                      );
                    }
                  },
                ).animate(onPlay: (controller) => controller.repeat(),).shimmer(duration: 2000.ms, delay: 1800.ms,color: theme.colorScheme.onPrimary).then(delay: 400.ms),
              ),
            ),
            BigButton(
              borderColor: theme.colorScheme.error , buttonColor: theme.colorScheme.errorContainer,
             
              title: 'Cancel',
              onTap: () => context.read<PrepareDataBloc>().add(
                PrepareDataBlocEvent_cancelAll(),
              ),
            ),

            Text(
              "Both parent photos are required to generate an accurate prediction",
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
