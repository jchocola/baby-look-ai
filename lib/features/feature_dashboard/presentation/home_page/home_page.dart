import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/core/app_text/app_text.dart';
import 'package:baby_look/features/feature_dashboard/presentation/widget/create_new_prediction_widget.dart';
import 'package:baby_look/features/feature_dashboard/presentation/widget/home_page_app_bar.dart';
import 'package:baby_look/features/feature_dashboard/presentation/widget/recent_predictions_widget.dart';
import 'package:baby_look/shared/note_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: HomePageAppBar(), body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    final theme = Theme.of(context);
    void onCreatePredictionTapped() {
      context.go('/generate');
    }

    return Padding(
      padding: EdgeInsets.all(AppConstant.appPadding),
      child: SingleChildScrollView(
        child: Column(
          spacing: AppConstant.appPadding,
          children: [
            CreateNewPredictionWidget(onTap: onCreatePredictionTapped),
            NoteWidget(
              color: theme.colorScheme.error,
              icon: AppIcon.ideaIcon,
              note:
                  context.tr(AppText.home_note),
            ),
            RecentPredictionsWidget(),
          ],
        ),
      ),
    );
  }
}
