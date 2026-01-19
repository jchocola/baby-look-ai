import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:baby_look/features/feature_user/bloc/user_bloc.dart';
import 'package:baby_look/shared/custom_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<AuthBloc, AuthBlocState>(
      builder: (context, state) {
        if (state is AuthBlocState_authenticated) {
          return Row(
            spacing: AppConstant.appPadding,
            children: [
              CustomCircleAvatar(
                url: state.user.photoURL ?? AppConstant.defaultAvatarUrl,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///
                    /// USER INFO
                    ///
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.user.email ?? 'Expecting Parent',
                              
                          style: theme.textTheme.titleMedium,
                        ),
                        Text(
                          '#' + state.user.uid.substring(0, 10),
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),

                    ///
                    /// COIN INFO
                    ///
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BlocBuilder<UserBloc,UserBlocState>(builder:(context,state)=> Text( state is UserBlocState_loaded ? state.userEntity.coins.toString() : '0', style: theme.textTheme.titleMedium)),
                        Text('coins', style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
