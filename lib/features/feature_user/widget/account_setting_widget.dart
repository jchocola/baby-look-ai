import 'package:baby_look/core/app_exception/app_exception.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/core/app_text/app_text.dart';
import 'package:baby_look/core/toastification/show_success_custom_toastification.dart';
import 'package:baby_look/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:baby_look/main.dart';
import 'package:baby_look/shared/custom_listile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AccountSettingWidget extends StatelessWidget {
  const AccountSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.tr(AppText.account), style: theme.textTheme.titleMedium),
        BlocConsumer<AuthBloc, AuthBlocState>(
          listener: (context, state) {
            if (state is AuthBlocState_success) {
              showSuccessCustomToastification(
                title: AppExceptionConverter(
                  context,
                  excetion: state.exception,
                ),
              );
            }
          },
          builder: (context, state) => CustomListile(
            onTap: state is AuthBlocState_authenticated && state.verifiedUser
                ? () {
                    logger.i('This account verified or login via telephone');
                    showSuccessCustomToastification(
                      title: AppExceptionConverter(
                        context,
                        excetion: AppException.account_verified,
                      ),
                    );
                  }
                : () {
                    context.read<AuthBloc>().add(
                      AuthBlocEvent_sendVerifyEmail(),
                    );
                  },
            title: state is AuthBlocState_authenticated && state.verifiedUser
                ? context.tr(AppText.profile_verified)
                : context.tr(AppText.profile_unverified),
            icon: state is AuthBlocState_authenticated && state.verifiedUser
                ? LucideIcons.userRoundCheck
                : LucideIcons.userRoundX,
          ),
        ),
        CustomListile(title: context.tr(AppText.purchases), icon: AppIcon.subscriptionIcon),
        CustomListile(
          onTap: () => context.go('/user/history'),
          title: context.tr(AppText.prediction_history),
          icon: AppIcon.predictionHistoryIcon,
        ),
      ],
    );
  }
}
