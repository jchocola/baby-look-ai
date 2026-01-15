// ignore_for_file: camel_case_types

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PrepareDataBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}



abstract class PrepareDataBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PrepareDataBlocState_initial extends PrepareDataBlocState {}

class PrepareDataBlocState_loaded extends PrepareDataBlocState {}

class PrepareDataBloc extends Bloc<PrepareDataBlocEvent, PrepareDataBlocState> {
  PrepareDataBloc() : super(PrepareDataBlocState_initial()) {

  }
}
