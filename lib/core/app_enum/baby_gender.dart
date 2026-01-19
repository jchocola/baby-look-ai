// ignore_for_file: constant_identifier_names, camel_case_types

import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:flutter/widgets.dart';

enum BABY_GENDER { BOY, GIRL, DONT_KNOW }

IconData genderToIcon({required String? gender}) {
  switch (gender) {
    case "BOY":
      return AppIcon.boyIcon;
    case "GIRL":
      return AppIcon.girlIcon;
    default:
      return AppIcon.ideaIcon;
  }
}

BABY_GENDER genderFromStr({required String gender}) {
    switch (gender) {
    case "BOY":
      return BABY_GENDER.BOY;
    case "GIRL":
      return BABY_GENDER.GIRL;
    default:
      return BABY_GENDER.DONT_KNOW;
  } 
}
