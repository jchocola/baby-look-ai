// ignore_for_file: camel_case_types

import 'package:baby_look/features/feature_auth/domain/repository/auth_repository.dart';
import 'package:baby_look/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// EVENT
///
abstract class AuthBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthBlocEvent_authViaFacebook extends AuthBlocEvent {}

///
/// STATE
///
abstract class AuthBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthBlocState_init extends AuthBlocState {}

///
/// BLOC
///
class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthBlocState_init()) {
    ///
    /// AUTH VIA FACEBOOK
    ///
    on<AuthBlocEvent_authViaFacebook>((event, emit) async {
      try {
        logger.d('Auth via facebook');
        await authRepository.authViaFacebook();
      } catch (e) {
        logger.e(e);
      }
    });
  }
}
