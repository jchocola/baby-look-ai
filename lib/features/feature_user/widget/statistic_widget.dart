import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_theme/app_color.dart';
import 'package:flutter/material.dart';

class StatisticWidget extends StatelessWidget {
  const StatisticWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
    
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2/1,
        crossAxisSpacing: AppConstant.appPadding
      ),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          color: AppColor.grayColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [Text('14'), Text('Prediction')],
          ),
        );
      },
    );
  }
}
