import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:flutter/material.dart';

class LoginViaOtherMethods extends StatelessWidget {
  const LoginViaOtherMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: AppConstant.appPadding,
          children: [
            Flexible(child: Divider()),
            Text('Sign up with'),
             Flexible(child: Divider()),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(onPressed: () {}, child: Text('Google')),
            TextButton(onPressed: () {}, child: Text('Facebook')),
            TextButton(onPressed: () {}, child: Text('Anonymous')),
            ],
        ),
      ],
    );
  }
}
