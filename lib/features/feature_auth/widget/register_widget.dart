import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_text/app_text.dart';
import 'package:baby_look/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:baby_look/shared/big_button.dart';
import 'package:baby_look/shared/custom_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
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
        CustomTextfield(labelText: context.tr(AppText.email), controller: emailController),
        CustomTextfield(
          labelText: context.tr(AppText.password),
          isObscure: true,
          controller: passwordController,
        ),
        CustomTextfield(
          labelText: context.tr(AppText.confirm_password),
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
          title:context.tr(AppText.register),
        ),
      ],
    );
  }
}
