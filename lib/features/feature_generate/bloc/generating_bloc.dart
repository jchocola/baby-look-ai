// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:baby_look/features/feature_generate/data/banana_pro_service.dart';
import 'package:baby_look/main.dart';

///
/// EVENTS
///
abstract class GeneratingBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GeneratingBlocEvent_generatePrediction extends GeneratingBlocEvent {
  final File ultrasoundImage;
  final File? fatherImage;
  final File? motherImage;
  final int gestationWeek;
  final String? gender;
  final String? additionalNotes;
  GeneratingBlocEvent_generatePrediction({
    required this.ultrasoundImage,
    required this.gestationWeek,
    this.fatherImage,
    this.motherImage,
    this.gender,
    this.additionalNotes,
  });
}

///
/// STATE
///
abstract class GeneratingBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GeneratingBlocState_initial extends GeneratingBlocState {}

class GeneratingBlocState_generating extends GeneratingBlocState {}

class GeneratingBlocState_generated extends GeneratingBlocState {}

class GeneratingBlocState_error extends GeneratingBlocState {}

class GeneratingBlocState_success extends GeneratingBlocState {}

///
/// BLOC
///
class GeneratingBloc extends Bloc<GeneratingBlocEvent, GeneratingBlocState> {
  final BananaProService bananaProService;

  GeneratingBloc({required this.bananaProService})
    : super(GeneratingBlocState_initial()) {
    ///
    /// GeneratingBlocEvent_generatePrediction
    ///
    on<GeneratingBlocEvent_generatePrediction>((event, emit) async {
      try {
        final response = await bananaProService.generateBabyPrediction(
          ultrasoundImage: event.ultrasoundImage,
          fatherImage: event.fatherImage,
          motherImage: event.motherImage,
          gestationWeek: event.gestationWeek,
          gender: event.gender,
          additionalNotes: event.additionalNotes,
        );

        logger.f(response);
      } catch (e) {
        logger.e(e);
      }
    });
  }
}
