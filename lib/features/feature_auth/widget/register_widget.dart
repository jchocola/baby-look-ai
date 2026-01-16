import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/shared/big_button.dart';
import 'package:baby_look/shared/custom_textfield.dart';
import 'package:flutter/material.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      spacing: AppConstant.appPadding,
      children: [
        CustomTextfield(labelText: 'Enter Email',),
        CustomTextfield(labelText: 'Password',isObscure: true,),
        CustomTextfield(labelText: 'Confirm Password',isObscure: true,),

        

        BigButton(
           borderColor: theme.colorScheme.primary,
          buttonColor: theme.colorScheme.primary.withOpacity(0.3),
          title: 'Register'),
      ],
    );
  }
}
