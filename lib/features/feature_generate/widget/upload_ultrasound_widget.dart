import 'dart:io';

import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/core/app_text/app_text.dart';
import 'package:baby_look/core/app_theme/app_color.dart';
import 'package:baby_look/features/feature_generate/bloc/prepare_data_bloc.dart';
import 'package:baby_look/shared/custom_rounded_icon.dart';
import 'package:baby_look/shared/picked_image_card.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadUltrasoundWidget extends StatelessWidget {
  const UploadUltrasoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        color: theme.colorScheme.secondary.withOpacity(0.5),
        strokeWidth: 3,
        padding: EdgeInsets.all(AppConstant.appPadding/2),
        dashPattern: [
          5,10,
        ],
        radius: Radius.circular(AppConstant.borderRadius * 1.3)
      ),
      child: SizedBox(
        height: size.width * 0.7,
        width: size.width * 0.7,
        //color: AppColor.blueColor3,
        child: BlocBuilder<PrepareDataBloc, PrepareDataBlocState>(
          builder: (context, state) {
            if (state is PrepareDataBlocState_loaded &&
                state.ultrasoundImage != null) {
              return ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(AppConstant.borderRadius),
                child: PickedImageCard(
                  file: File(state.ultrasoundImage!.path),
                  onCancelPressed: () => context.read<PrepareDataBloc>().add(
                    PrepareDataBlocEvent_cancelUtrasoundImage(),
                  ),
                ),
              );
            } else {
              return Container(
                
                 decoration: BoxDecoration(
                   color: theme.colorScheme.tertiaryFixed,
                  borderRadius: BorderRadius.circular(AppConstant.borderRadius)
                 ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: AppConstant.appPadding,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomRoundedIcon(icon: AppIcon.imageIcon,color: theme.colorScheme.onPrimary, iconColor: theme.colorScheme.primary,),
                    Text(context.tr(AppText.upload_ultrasound_scan), style: theme.textTheme.titleMedium, textAlign: TextAlign.center,),
                    Text(context.tr(AppText.upload_ultrasound_scan_note), style: theme.textTheme.bodySmall,textAlign: TextAlign.center),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
