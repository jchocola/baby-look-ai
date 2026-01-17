import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:baby_look/shared/custom_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<AuthBloc,AuthBlocState>(
      builder:(context,state)=> AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome back,', style: theme.textTheme.bodySmall),
            Text(state is AuthBlocState_authenticated ? state.user.displayName ?? 'Expecting Parent!' : '', style: theme.textTheme.titleMedium),
          ],
        ),
      
        actions: [
          IconButton(onPressed: () {}, icon: Icon(AppIcon.notificationIcon)),
          CustomCircleAvatar(
            url: state is AuthBlocState_authenticated ? state.user.photoURL ?? AppConstant.defaultAvatarUrl : AppConstant.defaultAvatarUrl,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppConstant.preferredSizeHeight);
}
