import 'package:auth_buttons/auth_buttons.dart';
import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:flutter/material.dart';

class LoginViaOtherMethods extends StatelessWidget {
  const LoginViaOtherMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppConstant.appPadding,
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
            GoogleAuthButton(
              onPressed: () {},
              style: AuthButtonStyle(
                buttonType: AuthButtonType.icon,
                iconType: AuthIconType.secondary,
              ),
            ),
            FacebookAuthButton(
              onPressed: () {},
              style: AuthButtonStyle(
                buttonType: AuthButtonType.icon,
                iconType: AuthIconType.secondary,
              ),
            ),
            GithubAuthButton(
               onPressed: () {},
              style: AuthButtonStyle(
                buttonType: AuthButtonType.icon,
                iconType: AuthIconType.secondary,
              ),
            )
          ],
        ),
        //  TextButton(onPressed: () {}, child: Text('Guest')),
      ],
    );
  }
}
