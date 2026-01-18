import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/features/feature_gallery/bloc/predictions_bloc.dart';
import 'package:baby_look/shared/generated_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RecentPredictionsWidget extends StatelessWidget {
  const RecentPredictionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Predictions', style: theme.textTheme.titleMedium),
            TextButton(
              onPressed: () {
                context.go('/gallery');
              },
              child: Text(
                'View All',
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        _buildGenerated(context),
      ],
    );
  }

  Widget _buildGenerated(BuildContext context) {
    return BlocBuilder<PredictionsBloc, PredictionsBlocState>(
      builder: (context, state) {
        if (state is PredictionsBlocState_loaded) {
          return GridView.builder(
            // only show latest 4
            itemCount: state.predictionList.length <= 4
                ? state.predictionList.length
                : 4,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: AppConstant.appPadding,
              crossAxisSpacing: AppConstant.appPadding,
              crossAxisCount: 2,
              childAspectRatio: 3 / 4,
            ),
            itemBuilder: (context, index) {
              final prediction = state.predictionList[index];
              return GeneratedCardWidget(
                prediction: prediction,
                onCardTap: () => context.go(
                  '/gallery/prediction_detail',
                  extra: prediction,
                ),
              );
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
