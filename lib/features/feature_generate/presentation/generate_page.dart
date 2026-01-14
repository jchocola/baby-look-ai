import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/features/feature_generate/presentation/generate_page1.dart';
import 'package:baby_look/features/feature_generate/presentation/generate_page2.dart';
import 'package:baby_look/features/feature_generate/presentation/generate_page3.dart';
import 'package:baby_look/features/feature_generate/presentation/processing_page.dart';
import 'package:baby_look/shared/custom_button_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
          child: PageView(
            controller: pageController,
            children: [GeneratePage1(), GeneratePage2(), GeneratePage3(), ProcessingPage()],
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [CustomButtonWithIcon(
            title: 'Back',
          ), CustomButtonWithIcon(
            title: 'Next',
          )],
        ),

        SmoothPageIndicator(controller: pageController, count: 4, effect: JumpingDotEffect(
          dotHeight: AppConstant.appPadding,
          dotWidth: AppConstant.appPadding
          
        ),),
      ],
    );
  }
}
