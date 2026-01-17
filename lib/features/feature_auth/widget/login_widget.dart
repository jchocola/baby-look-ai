import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:baby_look/features/feature_auth/presentation/modal/forgot_password_modal.dart';
import 'package:baby_look/shared/big_button.dart';
import 'package:baby_look/shared/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      spacing: AppConstant.appPadding,
      children: [
        CustomTextfield(
          labelText: 'Enter Email',
          focusBorderColor: theme.colorScheme.tertiary,
          cursorColor: theme.colorScheme.tertiary,
          controller: emailController,
        ),
        CustomTextfield(
          labelText: 'Password',
          isObscure: true,
          focusBorderColor: theme.colorScheme.tertiary,
          cursorColor: theme.colorScheme.tertiary,
          controller: passwordController,
        ),

        Align(
          alignment: AlignmentGeometry.centerRight,
          child: TextButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                showDragHandle: true,
                builder: (context) {
                  return SizedBox.fromSize(
                    size: Size.fromHeight(MediaQuery.of(context).size.height * 0.7),
                    child: ForgotPasswordModal());
                },
              );
            },
            child: Text('Forgot password?'),
          ),
        ),

        BigButton(
          borderColor: theme.colorScheme.tertiary,
          buttonColor: theme.colorScheme.tertiary.withOpacity(0.3),
          title: 'Log In',
          onTap: () {
            context.read<AuthBloc>().add(
              AuthBlocEvent_loginViaLoginPassword(
                login: emailController.text,
                password: passwordController.text,
              ),
            );
          },
        ),
      ],
    );
  }
}
