import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_theme/app_color.dart';
import 'package:flutter/material.dart';

class StatisticWidget extends StatelessWidget {
  const StatisticWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final _statistic = [
      {"title": "Predictions", "color": AppColor.pinkColor},
      {"title": "Favorites", "color": AppColor.blueColor},
      {"title": "Days Active", "color": AppColor.yellowColor},
    ];
    final theme = Theme.of(context);
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.8 / 1,
        crossAxisSpacing: AppConstant.appPadding,
      ),
      itemCount: _statistic.length,
      itemBuilder: (context, index) {
        final statistic = _statistic[index];
        return Container(
          //color: AppColor.grayColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '14',
                style: theme.textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: statistic["color"] as Color,
                ),
              ),
              Text(statistic["title"] as String),
            ],
          ),
        );
      },
    );
  }
}
