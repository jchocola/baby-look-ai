import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/features/feature_generate/widget/fun_facts_widget.dart';
import 'package:baby_look/features/feature_generate/widget/lottie_animation_widget.dart';
import 'package:baby_look/shared/big_button.dart';
import 'package:flutter/material.dart';

class ProcessingPage extends StatelessWidget {
  const ProcessingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:   EdgeInsets.symmetric(horizontal:  AppConstant.appPadding),
      child: Column(
        spacing: AppConstant.appPadding,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              LottieAnimationWidget(),
             // Transform.scale(scale: 4, child: CircularProgressIndicator(strokeWidth: AppConstant.appPadding/5,)),
            ],
          ),

          SizedBox.fromSize(size: Size.fromHeight(AppConstant.preferredSizeHeight),),
      
          LinearProgressIndicator(minHeight: AppConstant.appPadding,borderRadius: BorderRadius.circular(AppConstant.borderRadius),),

         FunFactsWidget(),
          
           SizedBox.fromSize(size: Size.fromHeight(AppConstant.preferredSizeHeight),),
          BigButton(title: 'Cancel',)
      
        ],
      ),
    );
  }
}
