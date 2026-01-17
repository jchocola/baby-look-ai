import 'package:auth_buttons/auth_buttons.dart';
import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:baby_look/features/feature_auth/presentation/modal/phone_number_imput_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginViaOtherMethods extends StatelessWidget {
  const LoginViaOtherMethods({super.key, this.phoneAuthColor = Colors.black54});
  final Color phoneAuthColor;
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
              onPressed: () {
                context.read<AuthBloc>().add(AuthBlocEvent_authViaGoogle());
              },
              style: AuthButtonStyle(
                buttonType: AuthButtonType.icon,
                iconType: AuthIconType.secondary,
              ),
            ),
            FacebookAuthButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthBlocEvent_authViaFacebook());
              },
              style: AuthButtonStyle(
                buttonType: AuthButtonType.icon,
                iconType: AuthIconType.secondary,
              ),
            ),

            IconButton.filled(
              style: ButtonStyle(
                backgroundColor:  WidgetStatePropertyAll(phoneAuthColor),
              ),
          
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  showDragHandle: true,
                  isScrollControlled: true,
                  builder: (context) {
                    return SizedBox.fromSize(
                      size: Size.fromHeight(MediaQuery.of(context).size.height * 0.8),
                      child: PhoneNumberImputModal(),
                    );
                  },
                );
              },
              icon: Icon(Icons.phone),
            ),

            GithubAuthButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthBlocEvent_authViaGitHub());
              },
              style: AuthButtonStyle(
                buttonType: AuthButtonType.icon,
                iconType: AuthIconType.secondary,
              ),
            ),

            TwitterAuthButton(
              onPressed: () {
                //context.read<AuthBloc>().add(AuthBlocEvent_authViaGitHub());
              },
              style: AuthButtonStyle(
                buttonType: AuthButtonType.icon,
                iconType: AuthIconType.secondary,
              ),
            ),
          ],
        ),
        //  TextButton(onPressed: () {}, child: Text('Guest')),
      ],
    );
  }
}
