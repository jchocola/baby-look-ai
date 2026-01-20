import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/core/app_text/app_text.dart';
import 'package:baby_look/features/feature_generate/bloc/prepare_data_bloc.dart';
import 'package:baby_look/features/feature_generate/widget/tips_for_best_result.dart';
import 'package:baby_look/features/feature_generate/widget/upload_ultrasound_widget.dart';
import 'package:baby_look/shared/custom_app_bar.dart';
import 'package:baby_look/shared/custom_button_with_icon.dart';
import 'package:baby_look/shared/note_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GeneratePage1 extends StatelessWidget {
  const GeneratePage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.tr(AppText.step1_appbar)),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(AppConstant.appPadding),
      child: SingleChildScrollView(
        child: Column(
        
          spacing: AppConstant.appPadding,
          children: [
            UploadUltrasoundWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButtonWithIcon(
                  icon: AppIcon.imageIcon,
                  title: context.tr(AppText.generating_gallery),
                  onTap: () {
                    context.read<PrepareDataBloc>().add(
                      PrepareDataBlocEvent_pickUltrasoundImageFromGallery(),
                    );
                  },
                ),
                CustomButtonWithIcon(
                  icon: AppIcon.cameratIcon,
                  title: context.tr(AppText.camera),
                  onTap: () {
                    context.read<PrepareDataBloc>().add(
                      PrepareDataBlocEvent_pickUltrasoundImageFromCamera(),
                    );
                  },
                ),
              ],
            ),
            TipsForBestResult(),
            NoteWidget(
              icon: AppIcon.infoIcon,
              note:
                 context.tr(AppText.step1_note),
              color: theme.colorScheme.tertiary,
            ),
          ],
        ),
      ),
    );
  }
}
