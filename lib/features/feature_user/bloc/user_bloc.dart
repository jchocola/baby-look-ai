// ignore_for_file: camel_case_types

import 'package:baby_look/main.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:baby_look/features/feature_user/domain/repo/user_db_repository.dart';
import 'package:baby_look/features/feature_user/domain/user_entity.dart';

///
/// EVENT
///
abstract class UserBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserBlocEvent_setUser extends UserBlocEvent {
  final User user;
  UserBlocEvent_setUser({required this.user});
  @override
  List<Object?> get props => [user];
}

///
/// STATE
///
abstract class UserBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserBlocState_init extends UserBlocState {}

class UserBlocState_loading extends UserBlocState {}

class UserBlocState_loaded extends UserBlocState {
  final UserEntity userEntity;
  UserBlocState_loaded({required this.userEntity});

  @override
  List<Object?> get props => [userEntity];
}

class UserBlocState_error extends UserBlocState {}

///
/// BLOC
///
class UserBloc extends Bloc<UserBlocEvent, UserBlocState> {
  UserDbRepository userDbRepository;

  UserBloc({required this.userDbRepository}) : super(UserBlocState_init()) {
    ///
    /// UserBlocEvent_setUser
    ///
    on<UserBlocEvent_setUser>((event, emit) async {
      try {
        final userEntity = await userDbRepository.getUserEntityFromUid(
          uid: event.user.uid,
        );
        logger.d("$userEntity");
        emit(UserBlocState_loaded(userEntity: userEntity));
      } catch (e) {
        logger.e(e);
      }
    });
  }
}
