import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_text/app_text.dart';
import 'package:baby_look/features/feature_gallery/bloc/predictions_bloc.dart';
import 'package:baby_look/shared/custom_app_bar.dart';
import 'package:baby_look/shared/empty_widget.dart';
import 'package:baby_look/shared/prediction_history_listile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PredictionHistoryPage extends StatelessWidget {
  const PredictionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.tr(AppText.prediction_history)),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: AppConstant.appPadding),
      child: BlocBuilder<PredictionsBloc, PredictionsBlocState>(
        builder: (context, state) {
          if (state is PredictionsBlocState_loaded) {
            ////
            /// EMPTY CASE
            ///
             if (state.predictionList.isEmpty) {
            return Center(child: EmptyWidget());
          }

            return ListView.builder(
              itemCount: state.predictionList.length,
              itemBuilder: (context, index) {
                final prediction = state.predictionList[index];
                return PredictionHistoryListile(
                  onTap: () {
                    context.go('/gallery/prediction_detail', extra: prediction);
                  },
                  prediction: prediction,
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
