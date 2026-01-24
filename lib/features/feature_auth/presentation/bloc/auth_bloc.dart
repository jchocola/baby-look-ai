// ignore_for_file: camel_case_types

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:baby_look/core/app_exception/app_exception.dart';
import 'package:baby_look/features/feature_auth/domain/repository/auth_repository.dart';
import 'package:baby_look/features/feature_gallery/bloc/predictions_bloc.dart';
import 'package:baby_look/features/feature_user/bloc/user_bloc.dart';
import 'package:baby_look/features/feature_user/domain/repo/user_db_repository.dart';
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

class AuthBlocEvent_verifyPhoneNumber extends AuthBlocEvent {
  final String phoneNumber;
  AuthBlocEvent_verifyPhoneNumber({required this.phoneNumber});
  @override
  List<Object?> get props => [phoneNumber];
}

class AuthBlocEvent_sendPassRecoverToEmail extends AuthBlocEvent {
  final String? email;
  AuthBlocEvent_sendPassRecoverToEmail({required this.email});

  @override
  List<Object?> get props => [email];
}

class AuthBlocEvent_checkSetupUserDataFirstTime extends AuthBlocEvent {
  final UserCredential? userCredential;
  AuthBlocEvent_checkSetupUserDataFirstTime({required this.userCredential});
  @override
  List<Object?> get props => [userCredential];
}

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

class AuthBlocState_waiting_verify_sms_code extends AuthBlocState {
  final String ?verificationId;
  AuthBlocState_waiting_verify_sms_code({required this.verificationId});
  @override
  List<Object?> get props => [verificationId];
}

class AuthBlocState_sendedPasswordRecoverEmail extends AuthBlocState {}

class AuthBlocState_error extends AuthBlocState {
  final AppException exception;
  AuthBlocState_error({required this.exception});
  @override
  List<Object?> get props => [exception];
}

class AuthBlocState_success extends AuthBlocState {
  final AppException exception;
  AuthBlocState_success({required this.exception});
  @override
  List<Object?> get props => [exception];
}

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
  final UserDbRepository userDbRepository;
  final UserBloc userBloc;
  final PredictionsBloc predictionsBloc;
  AuthBloc({
    required this.authRepository,
    required this.userDbRepository,
    required this.userBloc,
    required this.predictionsBloc,
  }) : super(AuthBlocState_init()) {
    ///
    /// AUTH CHECK
    ///
    on<AuthBlocEvent_authCheck>((event, emit) async {
      final user = await authRepository.getCurrentUser();
      logger.d('Auth check: ${user?.email}');

      if (user != null) {
        emit(AuthBlocState_authenticated(user: user));
        userBloc.add(UserBlocEvent_setUser(user: user));
        predictionsBloc.add(PredictionsBlocEvent_loadPredictions(user: user));
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

        final userCredential = await authRepository.authViaFacebook();

        add(
          AuthBlocEvent_checkSetupUserDataFirstTime(
            userCredential: userCredential,
          ),
        );
      } catch (e) {
        logger.e(e);
        emit(AuthBlocState_error(exception: e as AppException));
      } finally {
        add(AuthBlocEvent_authCheck());
      }
    });

    ///
    /// LOG OUT
    ///
    on<AuthBlocEvent_logout>((event, emit) async {
      try {
        logger.d('Log out');
        await authRepository.logOut();
      } catch (e) {
        logger.e(e);
        emit(AuthBlocState_error(exception: e as AppException));
      } finally {
        add(AuthBlocEvent_authCheck());
      }
    });

    ///
    /// AUTH VIA GITHUB
    ///
    on<AuthBlocEvent_authViaGitHub>((event, emit) async {
      try {
        logger.d('Auth via github');
        final userCredential = await authRepository.authViaGithub();

        add(
          AuthBlocEvent_checkSetupUserDataFirstTime(
            userCredential: userCredential,
          ),
        );
      } catch (e) {
        logger.e(e);
        emit(AuthBlocState_error(exception: e as AppException));
      } finally {
        add(AuthBlocEvent_authCheck());
      }
    });

    ///
    /// AUTH VIA GOOGLE
    ///
    on<AuthBlocEvent_authViaGoogle>((event, emit) async {
      try {
        logger.d('Auth via google');

        final userCredential = await authRepository.authViaGoogle();

        add(
          AuthBlocEvent_checkSetupUserDataFirstTime(
            userCredential: userCredential,
          ),
        );
      } catch (e) {
        logger.e(e);
        emit(AuthBlocState_error(exception: e as AppException));
      } finally {
        add(AuthBlocEvent_authCheck());
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
          throw AppException.empty_case;
        }

        await authRepository.authViaLoginPassword(
          login: event.login!,
          password: event.password!,
        );
      } catch (e) {
        logger.e(e);
        emit(AuthBlocState_error(exception: e as AppException));
      } finally {
        add(AuthBlocEvent_authCheck());
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
          throw AppException.empty_case;
        }
        if (event.password != event.confirmPassword) {
          throw AppException.password_does_not_matched;
        }

        final userCredential = await authRepository.registerNewUser(
          login: event.login!,
          password: event.password!,
        );

        add(
          AuthBlocEvent_checkSetupUserDataFirstTime(
            userCredential: userCredential,
          ),
        );
      } catch (e) {
        logger.e(e);
        emit(AuthBlocState_error(exception: e as AppException));
      } finally {
        add(AuthBlocEvent_authCheck());
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

          emit(
            AuthBlocState_success(exception: AppException.sended_verify_email),
          );
        }
      } catch (e) {
        logger.e(e);
        emit(AuthBlocState_error(exception: e as AppException));
      } finally {
        add(AuthBlocEvent_authCheck());
      }
    });

    ///
    /// SEND RECOVER PASSWORD EMAIL TO
    ///
    on<AuthBlocEvent_sendPassRecoverToEmail>((event, emit) async {
      try {
        if (event.email == null || event.email!.isEmpty) {
          throw AppException.empty_case;
        }
        await authRepository.sendPasswordRecoveyEmail(email: event.email!).then(
          (_) {
            emit(AuthBlocState_sendedPasswordRecoverEmail());
          },
        );
      } catch (e) {
        logger.e(e);
        emit(AuthBlocState_error(exception: e as AppException));
      } finally {
        add(AuthBlocEvent_authCheck());
      }
    });

    ///
    /// VERIFY PHONE NUMBER
    ///
    on<AuthBlocEvent_verifyPhoneNumber>((event, emit) async {
      try {
        final verificationId = await authRepository
            .getVerificationPhoneNumberId(phoneNumber: event.phoneNumber);
        emit(
          AuthBlocState_waiting_verify_sms_code(verificationId: verificationId),
        );
      } catch (e) {
        logger.e(e);
        emit(AuthBlocState_error(exception: e as AppException));
      }
    });

    ///
    /// CHECK SET UP USER DATA FIRST TIME
    ///
    on<AuthBlocEvent_checkSetupUserDataFirstTime>((event, emit) async {
      try {
        logger.d("SET UP USER DATA FIRST TIME");
        if (event.userCredential != null) {
          final isNewUser = await userDbRepository.isNewUser(
            userCredential: event.userCredential!,
          );

          if (isNewUser) {
            final currentUser = await authRepository.getCurrentUser();
            if (currentUser != null) {
              await userDbRepository.firstTimeSetup(user: currentUser);
            }
          }
        }
      } catch (e) {
        logger.e(e);
      }
    });
  }
}
