// ignore_for_file: camel_case_types

import 'package:baby_look/core/domain/local_db_repository.dart';
import 'package:baby_look/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// EVENT
///
abstract class AppConfigBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppConfigBlocEvent_load extends AppConfigBlocEvent {}

class AppConfigBlocEvent_toogleNotificationEnabilityValue
    extends AppConfigBlocEvent {}

///
/// STATE
///
abstract class AppConfigBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppConfigBlocState_init extends AppConfigBlocState {}

class AppConfigBlocState_loading extends AppConfigBlocState {}

class AppConfigBlocState_error extends AppConfigBlocState {}

class AppConfigBlocState_loaded extends AppConfigBlocState {
  final bool notificationEnability;
  AppConfigBlocState_loaded({required this.notificationEnability});
  @override
  List<Object?> get props => [notificationEnability];
}

///
/// BLOC
///
class AppConfigBloc extends Bloc<AppConfigBlocEvent, AppConfigBlocState> {
  final LocalDbRepository localDbRepository;
  AppConfigBloc({required this.localDbRepository})
    : super(AppConfigBlocState_init()) {
    ///
    /// LOAD
    ///
    on<AppConfigBlocEvent_load>((event, emit) async {
      try {
        final notificationEnability = await localDbRepository
            .getNotificationEnablity();

        emit(
          AppConfigBlocState_loaded(
            notificationEnability: notificationEnability,
          ),
        );
      } catch (e) {
        logger.e(e);
        emit(AppConfigBlocState_error());
      }
    });

    on<AppConfigBlocEvent_toogleNotificationEnabilityValue>((
      event,
      emit,
    ) async {
      try {
        await localDbRepository.toogleEnablityNotification();
        add(AppConfigBlocEvent_load());
      } catch (e) {
        logger.e(e);
      }
    });
  }
}
