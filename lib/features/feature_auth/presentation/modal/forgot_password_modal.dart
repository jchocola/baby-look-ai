import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_text/app_text.dart';
import 'package:baby_look/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:baby_look/shared/big_button.dart';
import 'package:baby_look/shared/custom_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordModal extends StatefulWidget {
  const ForgotPasswordModal({super.key});

  @override
  State<ForgotPasswordModal> createState() => _ForgotPasswordModalState();
}

class _ForgotPasswordModalState extends State<ForgotPasswordModal> {
  late TextEditingController emailController;
  late bool isStep1;

  void changeToStep2() {
    setState(() {
      isStep1 = false;
    });
  }

  @override
  void initState() {
    super.initState();
    isStep1 = true;
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(

       body: isStep1 ? buildBody1(context) : buildBody2(context),
      ),
    );
  }

  Widget buildBody1(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        //spacing: AppConstant.appPadding,
        children: [
          Text(context.tr(AppText.forgot_password), style: theme.textTheme.titleLarge),
          Text(
            context.tr(AppText.enter_email_to_reset_password),
            style: theme.textTheme.bodySmall,
          ),
          SizedBox(height: AppConstant.appPadding),
          CustomTextfield(labelText: context.tr(AppText.email), controller: emailController),
          SizedBox(height: AppConstant.appPadding),
          BlocListener<AuthBloc, AuthBlocState>(
            listener: (context, state) {
              if (state is AuthBlocState_sendedPasswordRecoverEmail) {
                changeToStep2();
              }
            },
            child: BigButton(
              title: context.tr(AppText.send_password),
              onTap: () {
                context.read<AuthBloc>().add(
                  AuthBlocEvent_sendPassRecoverToEmail(
                    email: emailController.text,
                  ),
                );
              },
              borderColor: theme.colorScheme.primary,
              buttonColor: theme.colorScheme.onPrimary,
            ),
          ),
          SizedBox(height: AppConstant.appPadding * 3),

          Text(context.tr(AppText.dont_remember_email), style: theme.textTheme.bodySmall),
          Row(
            spacing: AppConstant.appPadding / 2,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(context.tr(AppText.contact_us), style: theme.textTheme.bodySmall),
              Text(
                AppConstant.supportEmail,
                style: theme.textTheme.titleSmall!.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBody2(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        //spacing: AppConstant.appPadding,
        children: [
          Text(context.tr(AppText.password_reset_send), style: theme.textTheme.titleLarge),
          Text(
            context.tr(AppText.check_email),
            style: theme.textTheme.bodySmall,
          ),
          Text(context.tr(AppText.check_spam), style: theme.textTheme.bodySmall),
          SizedBox(height: AppConstant.appPadding),

          SizedBox(height: AppConstant.appPadding),
          // BigButton(
          //   title: 'Open My Mail',
          //   borderColor: theme.colorScheme.tertiary,
          //   buttonColor: theme.colorScheme.onTertiary,
          //   icon: Icon(AppIcon.emailIcon),
          // ),
          SizedBox(height: AppConstant.appPadding * 3),

          Text(context.tr(AppText.dont_receive_email), style: theme.textTheme.bodySmall),
          Row(
            spacing: AppConstant.appPadding / 2,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(context.tr(AppText.contact_us), style: theme.textTheme.bodySmall),
              Text(
                AppConstant.supportEmail,
                style: theme.textTheme.titleSmall!.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
