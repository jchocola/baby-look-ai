import 'dart:io';
import 'dart:typed_data';

import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/core/app_text/app_text.dart';
import 'package:baby_look/features/feature_generate/bloc/generating_bloc.dart';
import 'package:baby_look/features/feature_generate/bloc/prepare_data_bloc.dart';
import 'package:baby_look/main.dart';
import 'package:baby_look/shared/big_button.dart';
import 'package:baby_look/shared/custom_app_bar.dart';
import 'package:baby_look/shared/custom_rounded_icon.dart';
import 'package:baby_look/shared/note_widget.dart';
import 'package:baby_look/shared/small_picked_image_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';

class ImageViewerAfterGenerating extends StatefulWidget {
  const ImageViewerAfterGenerating({super.key, required this.imageBytes});
  final Uint8List imageBytes;

  @override
  State<ImageViewerAfterGenerating> createState() =>
      _ImageViewerAfterGeneratingState();
}

class _ImageViewerAfterGeneratingState
    extends State<ImageViewerAfterGenerating> {
  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.tr(AppText.your_baby_prediction)),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppConstant.appPadding,
          children: [
            CustomRoundedIcon(
                  icon: AppIcon.favouriteRoundedIcon,
                  color: theme.colorScheme.onPrimary,
                  iconColor: theme.colorScheme.primary,
                )
                .animate(
                  onPlay: (controller) => controller.repeat(reverse: true),
                )
                .scaleXY(end: 3, duration: 3000.ms)
                .then(delay: 500.ms),

            ///
            /// SCRENSHOT ZONE
            ///
            Screenshot(
              controller: screenshotController,
              child: Column(
                spacing: AppConstant.appPadding,
                children: [
                  Text(
                    context.tr(AppText.meet_your_baby),
                    style: theme.textTheme.titleLarge,
                  ),
                  Text(
                    context.tr(AppText.ai_note1),
                    style: theme.textTheme.titleSmall,
                  ),

                  ///
                  /// OUTPUT PHOTO
                  ///
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(
                          AppConstant.borderRadius,
                        ),
                        child: SizedBox(
                          height: size.width * 0.8,
                          width: size.width * 0.8,
                          child: Image.memory(
                            widget.imageBytes,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: AppConstant.appPadding / 2,
                        right: AppConstant.appPadding / 2,
                        child: Text(
                          'BabyLook AI',
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),

                  ///
                  /// IMPUT PHOTOS
                  ///
                  BlocBuilder<PrepareDataBloc, PrepareDataBlocState>(
                    builder: (context, state) {
                      if (state is PrepareDataBlocState_loaded) {
                        return Row(
                          spacing: AppConstant.appPadding,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SmallPickedImageCard(
                              file: File(state.ultrasoundImage!.path),
                            ),
                            state.motherImage != null
                                ? SmallPickedImageCard(
                                    file: File(state.motherImage!.path),
                                  )
                                : Container(),
                            state.fatherImage != null
                                ? SmallPickedImageCard(
                                    file: File(state.fatherImage!.path),
                                  )
                                : Container(),
                          ],
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ),

            ///
            /// SAVE TO GALLERY
            ///
            BlocBuilder<GeneratingBloc, GeneratingBlocState>(
              builder: (context, state) => BigButton(
                title: context.tr(AppText.save_to_gallery),
                icon: Icon(AppIcon.saveIcon),
                borderColor: theme.colorScheme.primary,

                buttonColor: theme.colorScheme.onPrimary,
                onTap: () {
                  logger.d(state);
                  if (state is GeneratingBlocState_generated) {
                    context.read<GeneratingBloc>().add(
                      GeneratingBlocEvent_saveImageByteToGallery(
                        imageBytes: state.generatedImage,
                      ),
                    );
                  }
                },
              ),
            ),
            Row(
              spacing: AppConstant.appPadding,
              children: [
                Expanded(
                  child:
                      BigButton(
                            onTap: () async {
                              // TODO : SCREENSHOT LOGIC
                              final bytes = await screenshotController
                                  .capture();

                              context.read<GeneratingBloc>().add(
                                GeneratingBlocEvent_saveImageByteToGallery(
                                  imageBytes: bytes!,
                                ),
                              );
                              // logger.f(bytes);
                            },
                            title: context.tr(AppText.take_screenshot),
                            icon: Icon(AppIcon.cameratIcon),
                            borderColor: theme.colorScheme.error,
                            buttonColor: theme.colorScheme.errorContainer,
                          )
                          .animate(onPlay: (controller) => controller.repeat())
                          .shimmer(duration: 1000.ms, delay: 500.ms),
                ),
              ],
            ),

            NoteWidget(
              icon: AppIcon.infoIcon,
              note: context.tr(AppText.ai_note2),
            ),
          ],
        ),
      ),
    );
  }
}
