import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:baby_look/shared/big_button.dart';
import 'package:baby_look/shared/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      spacing: AppConstant.appPadding,
      children: [
        CustomTextfield(labelText: 'Enter Email', controller: emailController),
        CustomTextfield(
          labelText: 'Password',
          isObscure: true,
          controller: passwordController,
        ),
        CustomTextfield(
          labelText: 'Confirm Password',
          isObscure: true,
          controller: confirmController,
        ),

        BigButton(
          onTap: () {
            context.read<AuthBloc>().add(
              AuthBlocEvent_register(login: emailController.text, password: passwordController.text, confirmPassword: confirmController.text),
            );
          },
          borderColor: theme.colorScheme.primary,
          buttonColor: theme.colorScheme.primary.withOpacity(0.3),
          title: 'Register',
        ),
      ],
    );
  }
}
