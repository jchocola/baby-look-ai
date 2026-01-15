import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/features/feature_dashboard/presentation/widget/create_new_prediction_widget.dart';
import 'package:baby_look/features/feature_dashboard/presentation/widget/home_page_app_bar.dart';
import 'package:baby_look/features/feature_dashboard/presentation/widget/recent_predictions_widget.dart';
import 'package:baby_look/shared/note_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: HomePageAppBar(), body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    void onCreatePredictionTapped() {
      context.go('/generate');
    }

    return Padding(
      padding: EdgeInsets.all(AppConstant.appPadding),
      child: SingleChildScrollView(
        child: Column(
          spacing: AppConstant.appPadding,
          children: [
            CreateNewPredictionWidget(onTap: onCreatePredictionTapped,),
            NoteWidget(
              note:
                  'Weeks 24-28 provide the clearest ultrasound images for AI analysis.',
            ),
            RecentPredictionsWidget(),
          ],
        ),
      ),
    );
  }
}
