// ignore_for_file: camel_case_types

import 'package:baby_look/features/feature_auth/domain/repository/auth_repository.dart';
import 'package:baby_look/main.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// EVENT
///
abstract class AuthBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthBlocEvent_authCheck extends AuthBlocEvent {}

class AuthBlocEvent_authViaFacebook extends AuthBlocEvent {}

class AuthBlocEvent_logout extends AuthBlocEvent {}

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

  AuthBlocState_authenticated({required this.user});
  @override
  List<Object?> get props => [user];
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
  }
}
