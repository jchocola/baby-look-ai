import 'package:baby_look/core/app_text/app_text.dart';
import 'package:baby_look/core/app_theme/app_color.dart';
import 'package:baby_look/core/utils/get_diffent_day.dart';
import 'package:baby_look/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:baby_look/features/feature_gallery/bloc/predictions_bloc.dart';
import 'package:baby_look/features/feature_user/bloc/user_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    return Row(
      children: [
        Expanded(
          child: BlocBuilder<PredictionsBloc, PredictionsBlocState>(
            builder: (context, state) => _statisticCard(
              color: AppColor.pinkColor,
              title: context.tr(AppText.predictions),
              value: state is PredictionsBlocState_loaded
                  ? state.predictionList.length.toString()
                  : '0',
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<UserBloc, UserBlocState>(
            builder: (context, state) => _statisticCard(
              color: AppColor.blueColor,
              title: context.tr(AppText.favourites),
              value: state is UserBlocState_loaded
                  ? state.userEntity.favourites.length.toString()
                  : '0',
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<AuthBloc, AuthBlocState>(
            builder: (context, state) => _statisticCard(
              title:context.tr(AppText.days_active),
              color: AppColor.yellowColor,
              value: state is AuthBlocState_authenticated
                  ? '${getDifferentDay(creationTime: state.user.metadata.creationTime)} '
                  : '0',
            ),
          ),
        ),
      ],
    );
  }

  // return GridView.builder(
  //   shrinkWrap: true,
  //   physics: NeverScrollableScrollPhysics(),
  //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //     crossAxisCount: 3,
  //     childAspectRatio: 1.8 / 1,
  //     crossAxisSpacing: AppConstant.appPadding,
  //   ),
  //   itemCount: _statistic.length,
  //   itemBuilder: (context, index) {
  //     final statistic = _statistic[index];
  //     return Container(
  //       //color: AppColor.grayColor,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Text(
  //             '14',
  //             style: theme.textTheme.headlineLarge!.copyWith(
  //               fontWeight: FontWeight.bold,
  //               color: statistic["color"] as Color,
  //             ),
  //           ),
  //           Text(statistic["title"] as String),
  //         ],
  //       ),
  //     );
  //   },
  // );
}

class _statisticCard extends StatelessWidget {
  const _statisticCard({
    super.key,
    this.title = 'Default',
    this.value = 'Default',
    this.color = Colors.black54,
  });
  final String title;
  final String value;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      //color: AppColor.grayColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: theme.textTheme.headlineLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(title, maxLines: 1,),
        ],
      ),
    );
  }
}
