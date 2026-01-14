import 'package:baby_look/core/app_constant/app_constant.dart';
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
          Transform.scale(scale: 4, child: CircularProgressIndicator(strokeWidth: AppConstant.appPadding/5,)),

          SizedBox.fromSize(size: Size.fromHeight(AppConstant.preferredSizeHeight),),
      
          LinearProgressIndicator(value: 0.3,minHeight: AppConstant.appPadding,borderRadius: BorderRadius.circular(AppConstant.borderRadius),),

          Text('Progress Text'),
          
           SizedBox.fromSize(size: Size.fromHeight(AppConstant.preferredSizeHeight),),
          BigButton(title: 'Cancel',)
      
        ],
      ),
    );
  }
}
