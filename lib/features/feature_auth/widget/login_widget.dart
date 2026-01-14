import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/shared/big_button.dart';
import 'package:baby_look/shared/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppConstant.appPadding,
      children: [
        CustomTextfield(),
        CustomTextfield(),

        Align(
          alignment: AlignmentGeometry.centerRight,
          child: TextButton(onPressed: () {}, child: Text('Forgot password?')),
        ),

        BigButton(
          title: 'Log In',
          onTap: () {
            context.go('/home');
          },
        ),
      ],
    );
  }
}
