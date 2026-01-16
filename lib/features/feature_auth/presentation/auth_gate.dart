import 'package:baby_look/core/di/DI.dart';
import 'package:baby_look/features/feature_auth/domain/repository/auth_repository.dart';
import 'package:baby_look/features/feature_auth/presentation/auth_page.dart';
import 'package:baby_look/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:baby_look/features/feature_dashboard/presentation/home_page/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is AuthBlocState_authenticated) {
          context.go('/home');
        } else {
           context.go('/auth');
        }
      },
      builder: (context, state) {
        return AuthPage();
      },
    );
    // return StreamBuilder(
    //   stream: getIt<AuthRepository>().userStream(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData && snapshot.data != null) {
    //       return HomePage();
    //     } else {
    //       return AuthPage();
    //     }
    //   },
    // );
  }
}
