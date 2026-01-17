// ignore_for_file: camel_case_types

import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:baby_look/features/feature_auth/domain/repository/auth_repository.dart';
import 'package:baby_look/main.dart';

///
/// EVENT
///
abstract class AuthBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthBlocEvent_authCheck extends AuthBlocEvent {}

class AuthBlocEvent_authViaFacebook extends AuthBlocEvent {}

class AuthBlocEvent_authViaGitHub extends AuthBlocEvent {}

class AuthBlocEvent_authViaGoogle extends AuthBlocEvent {}

class AuthBlocEvent_logout extends AuthBlocEvent {}

class AuthBlocEvent_sendVerifyEmail extends AuthBlocEvent {}

class AuthBlocEvent_loginViaLoginPassword extends AuthBlocEvent {
  final String? login;
  final String? password;
  AuthBlocEvent_loginViaLoginPassword({this.login, this.password});

  @override
  List<Object?> get props => [login, password];
}

class AuthBlocEvent_register extends AuthBlocEvent {
  final String? login;
  final String? password;
  final String? confirmPassword;
  AuthBlocEvent_register({this.login, this.password, this.confirmPassword});

  @override
  List<Object?> get props => [login, password, confirmPassword];
}

///
/// STATE
///
abstract class AuthBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthBlocState_init extends AuthBlocState {}

class AuthBlocState_unauthenticated extends AuthBlocState {}

class AuthBlocState_authenticated extends AuthBlocState {
  final User user;

  bool get verifiedUser => user.emailVerified || user.phoneNumber != null;

  AuthBlocState_authenticated({required this.user});
  @override
  List<Object?> get props => [user, verifiedUser];
}

///
/// BLOC
///
class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthBlocState_init()) {
    ///
    /// AUTH CHECK
    ///
    on<AuthBlocEvent_authCheck>((event, emit) async {
      final user = await authRepository.getCurrentUser();
      logger.d('Auth check: ${user?.email}');

      if (user != null) {
        emit(AuthBlocState_authenticated(user: user));
      } else {
        emit(AuthBlocState_unauthenticated());
      }
    });

    ///
    /// AUTH VIA FACEBOOK
    ///
    on<AuthBlocEvent_authViaFacebook>((event, emit) async {
      try {
        logger.d('Auth via facebook');

        await authRepository.authViaFacebook();

        add(AuthBlocEvent_authCheck());
      } catch (e) {
        logger.e(e);
      }
    });

    ///
    /// LOG OUT
    ///
    on<AuthBlocEvent_logout>((event, emit) async {
      try {
        logger.d('Log out');
        await authRepository.logOut();

        add(AuthBlocEvent_authCheck());
      } catch (e) {
        logger.e(e);
      }
    });

    ///
    /// AUTH VIA GITHUB
    ///
    on<AuthBlocEvent_authViaGitHub>((event, emit) async {
      try {
        logger.d('Auth via github');

        await authRepository.authViaGithub();

        add(AuthBlocEvent_authCheck());
      } catch (e) {
        logger.e(e);
      }
    });

    ///
    /// AUTH VIA GOOGLE
    ///
    on<AuthBlocEvent_authViaGoogle>((event, emit) async {
      try {
        logger.d('Auth via google');

        await authRepository.authViaGoogle();

        add(AuthBlocEvent_authCheck());
      } catch (e) {
        logger.e(e);
      }
    });

    ///
    /// AUTH WITH LOGIN PASSWORD
    ///
    on<AuthBlocEvent_loginViaLoginPassword>((event, emit) async {
      try {
        logger.d('Sign in  user ${event.login} : ${event.password}');
        if (event.login == null ||
            event.login!.isEmpty ||
            event.password == null ||
            event.password!.isEmpty) {
          throw 'Empty case';
        }

        await authRepository.authViaLoginPassword(
          login: event.login!,
          password: event.password!,
        );
        add(AuthBlocEvent_authCheck());
      } catch (e) {
        logger.e(e);
      }
    });

    ///
    /// REGISTER
    ///
    on<AuthBlocEvent_register>((event, emit) async {
      try {
        logger.d('Register user');

        if (event.confirmPassword == null ||
            event.confirmPassword!.isEmpty ||
            event.login == null ||
            event.login!.isEmpty ||
            event.password == null ||
            event.password!.isEmpty) {
          throw 'Empty case';
        }
        if (event.password != event.confirmPassword) {
          throw 'passwords doesnt matched';
        }

        await authRepository.registerNewUser(
          login: event.login!,
          password: event.password!,
        );

        add(AuthBlocEvent_authCheck());
      } catch (e) {
        logger.e(e);
      }
    });

    ///
    /// SEND VERIFY EMAIL
    ///
    on<AuthBlocEvent_sendVerifyEmail>((event, emit) async {
      try {
        final currentState = state;
        if (currentState is AuthBlocState_authenticated) {
          await authRepository.sendVerifyEmail(user: currentState.user);
        }
      } catch (e) {
        logger.e(e);
      }
    });
  }
}
