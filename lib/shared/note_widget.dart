import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_theme/app_color.dart';
import 'package:baby_look/shared/custom_rounded_icon.dart';
import 'package:flutter/material.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key, this.note = 'Default'});
  final String note;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.yellowColor,
      child: Row(
        spacing: AppConstant.appPadding,
        children: [CustomRoundedIcon(), Flexible(child: Text(note))]),
    );
  }
}
