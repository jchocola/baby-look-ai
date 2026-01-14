import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/shared/big_button.dart';
import 'package:baby_look/shared/custom_textfield.dart';
import 'package:flutter/material.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppConstant.appPadding,
      children: [
        CustomTextfield(),
        CustomTextfield(),
        CustomTextfield(),

        

        BigButton(title: 'Register'),
      ],
    );
  }
}
