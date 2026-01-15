import 'dart:io';

import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/core/app_theme/app_color.dart';
import 'package:baby_look/features/feature_generate/bloc/prepare_data_bloc.dart';
import 'package:baby_look/shared/picked_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadUltrasoundWidget extends StatelessWidget {
  const UploadUltrasoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(AppConstant.borderRadius),
      child: Container(
        height: size.width * 0.6,
        width: size.width * 0.6,
        color: AppColor.blueColor3,
        child: BlocBuilder<PrepareDataBloc, PrepareDataBlocState>(
          builder: (context, state) {
            if (state is PrepareDataBlocState_loaded &&
                state.ultrasoundImage != null) {
              return PickedImageCard(
                file: File(state.ultrasoundImage!.path),
                onCancelPressed: () => context.read<PrepareDataBloc>().add(PrepareDataBlocEvent_cancelUtrasoundImage()),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: AppConstant.appPadding,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(AppIcon.imageIcon),
                  Text('Upload Ultrasound Scan'),
                  Text('Select your clearest ultrasound image'),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
