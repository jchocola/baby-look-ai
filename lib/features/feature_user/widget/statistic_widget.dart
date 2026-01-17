import 'package:baby_look/core/app_theme/app_color.dart';
import 'package:baby_look/core/utils/get_diffent_day.dart';
import 'package:baby_look/features/feature_auth/presentation/bloc/auth_bloc.dart';
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
        Expanded(child: _statisticCard(title: 'Predictions')),
        Expanded(child: _statisticCard(title: "Favorites")),
        Expanded(
          child: BlocBuilder<AuthBloc, AuthBlocState>(
            builder: (context, state) => _statisticCard(
              title: "Days Active",
              color:AppColor.yellowColor ,
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
        children: [
          Text(
            value,
            style: theme.textTheme.headlineLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(title),
        ],
      ),
    );
  }
}
