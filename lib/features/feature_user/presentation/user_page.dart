import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:baby_look/features/feature_user/widget/account_setting_widget.dart';
import 'package:baby_look/features/feature_user/widget/copyright_widget.dart';
import 'package:baby_look/features/feature_user/widget/legal_info_widget.dart';
import 'package:baby_look/features/feature_user/widget/preferrences_setting_widget.dart';
import 'package:baby_look/features/feature_user/widget/profile_card.dart';
import 'package:baby_look/features/feature_user/widget/statistic_widget.dart';
import 'package:baby_look/shared/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile'),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
      child: SingleChildScrollView(
        child: Column(
          spacing: AppConstant.appPadding,
          children: [
            ProfileCard(),
            StatisticWidget(),
            Divider(),
            AccountSettingWidget(),
            PreferrencesSettingWidget(),
            LegalInfoWidget(),
            CopyrightWidget(),

            BlocListener<AuthBloc, AuthBlocState>(
              listener: (context, state) {
                if (state is AuthBlocState_unauthenticated) {
                  context.go('/auth');
                }
              },
              child: TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthBlocEvent_logout());
                },
                child: Text('LOG OUT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
