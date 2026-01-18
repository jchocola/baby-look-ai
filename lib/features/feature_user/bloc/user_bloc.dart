// ignore_for_file: camel_case_types

import 'package:baby_look/features/feature_auth/domain/repository/auth_repository.dart';
import 'package:baby_look/features/feature_user/data/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:baby_look/features/feature_generate/domain/prediction_entity.dart';
import 'package:baby_look/features/feature_user/domain/repo/user_db_repository.dart';
import 'package:baby_look/features/feature_user/domain/user_entity.dart';
import 'package:baby_look/main.dart';

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

class UserBlocEvent_reloadUser extends UserBlocEvent {}

class UserBlocEvent_likeOrUnlikePrediction extends UserBlocEvent {
  final PredictionEntity prediction;
  UserBlocEvent_likeOrUnlikePrediction({required this.prediction});
  @override
  List<Object?> get props => [prediction];
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

  UserBlocState_loaded copyWith({UserEntity? userEntity}) {
    return UserBlocState_loaded(userEntity: userEntity ?? this.userEntity);
  }
}

class UserBlocState_error extends UserBlocState {}

///
/// BLOC
///
class UserBloc extends Bloc<UserBlocEvent, UserBlocState> {
  final UserDbRepository userDbRepository;
  final AuthRepository authRepository;

  UserBloc({required this.userDbRepository,required this.authRepository}) : super(UserBlocState_init()) {
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

    ///
    /// RELOAD USER
    ///
    on<UserBlocEvent_reloadUser>((event, emit) async {
      try {
        logger.d('RELOAD USER');

        final currentUser = await authRepository.getCurrentUser();

        if (currentUser != null) {
          add(UserBlocEvent_setUser(user: currentUser));
        }
      } catch (e) {
        logger.e(e);
      }
    });

    ///
    /// LIKE OR UNLINE PREDICTION
    ///
   on<UserBlocEvent_likeOrUnlikePrediction>((event, emit) async {
      try {
        final currentState = state;

        if (currentState is UserBlocState_loaded) {
          // Создаём копию списка, не мутируем оригинал
          final favList = List<String>.from(currentState.userEntity.favourites);

          // POSITIVE UI
          final bool isLiked = favList.contains(event.prediction.id);

          if (isLiked) {
            // remove
            favList.remove(event.prediction.id);
          } else {
            // add
            favList.add(event.prediction.id);
          }

          // Создаём новый userEntity с новым списком и эмитим новый стейт
          final updatedUser = UserModel.fromEntity(
            currentState.userEntity,
          ).copyWith(favourites: favList).toEntity();
          emit(currentState.copyWith(userEntity: updatedUser));

          // update on db (если упадёт — можно откатить или показать ошибку)
          await userDbRepository.likeOrUnlikePrediction(
            user: currentState.userEntity,
            prediction: event.prediction,
          );
        }
      } catch (e) {
        logger.e(e);
      } 
    finally { add(UserBlocEvent_reloadUser()); }
    });
  }
}
