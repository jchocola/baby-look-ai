import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_exception/app_exception.dart';
import 'package:baby_look/core/app_text/app_text.dart';
import 'package:baby_look/core/di/DI.dart';
import 'package:baby_look/core/domain/vibrattion_repository.dart';
import 'package:baby_look/core/toastification/show_error_custom_toastification.dart';
import 'package:baby_look/core/toastification/show_success_custom_toastification.dart';
import 'package:baby_look/features/feature_generate/bloc/generating_bloc.dart';
import 'package:baby_look/features/feature_generate/presentation/generate_page1.dart';
import 'package:baby_look/features/feature_generate/presentation/generate_page2.dart';
import 'package:baby_look/features/feature_generate/presentation/generate_page3.dart';
import 'package:baby_look/features/feature_generate/presentation/processing_page.dart';
import 'package:baby_look/shared/custom_button_with_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:toastification/toastification.dart';

class GeneratePage extends StatefulWidget {
  const GeneratePage({super.key});

  @override
  State<GeneratePage> createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppConstant.appPadding,
      children: [
        Expanded(
          child: BlocConsumer<GeneratingBloc, GeneratingBlocState>(
            listener: (context, state) {
              if (state is GeneratingBlocState_generated) {
                context.read<GeneratingBloc>().add(
                  GeneratingBlocEvent_showNotificationAfterGenerating(
                    title: context.tr(AppText.notification_title),
                    body: context.tr(AppText.notification_body),
                  ),
                );

                showSuccessCustomToastification(title: context.tr(AppText.image_generated));
                getIt<VibrattionRepository>().vibrate();

                context.go(
                  '/gallery/image_viewer_after_generating',
                  extra: state.generatedImage,
                );
              }
              if (state is GeneratingBlocState_error) {
                showErrorCustomToastification(
                  title: AppExceptionConverter(context, exception: state.error),
                );
              }
            },

            builder: (context, state) {
              if (state is GeneratingBlocState_generating) {
                return ProcessingPage();
              } else {
                return PageView(
                  controller: pageController,
                  children: [GeneratePage1(), GeneratePage2(), GeneratePage3()],
                );
              }
            },
          ),
        ),

        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: [CustomButtonWithIcon(
        //     title: 'Back',
        //   ), CustomButtonWithIcon(
        //     title: 'Next',
        //   )],
        // ),
        SmoothPageIndicator(
          controller: pageController,
          count: 3,
          effect: JumpingDotEffect(
            dotHeight: AppConstant.appPadding,
            dotWidth: AppConstant.appPadding,
          ),
        ),
      ],
    );
  }
}
