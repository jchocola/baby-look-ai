// ignore_for_file: camel_case_types

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:baby_look/features/feature_generate/domain/prediction_db_repository.dart';
import 'package:baby_look/features/feature_generate/domain/prediction_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' show Image;

import 'package:baby_look/features/feature_generate/data/banana_pro_service.dart';
import 'package:baby_look/main.dart';
import 'package:uuid/uuid.dart';

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
  final User? user;
  GeneratingBlocEvent_generatePrediction({
    required this.ultrasoundImage,
    required this.gestationWeek,
    this.fatherImage,
    this.motherImage,
    this.gender,
    this.additionalNotes,
     this.user,
  });

  @override
  List<Object?> get props => [
    ultrasoundImage,
    fatherImage,
    motherImage,
    gestationWeek,
    gender,
    additionalNotes,
    user,
  ];
}

class GeneratingBlocEvent_saveGeneratePredictionImage
    extends GeneratingBlocEvent {
  final Uint8List imageBytes;
  final User user;
  final int gestationWeek;
  final String? gender;

  GeneratingBlocEvent_saveGeneratePredictionImage({
    required this.user,
    required this.imageBytes,
    required this.gestationWeek,
    this.gender,
  });

  @override
  List<Object?> get props => [user, imageBytes, gestationWeek, gender];
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

class GeneratingBlocState_generated extends GeneratingBlocState {
  final Uint8List generatedImage;
  GeneratingBlocState_generated({required this.generatedImage});

  @override
  List<Object?> get props => [generatedImage];
}

class GeneratingBlocState_error extends GeneratingBlocState {}

class GeneratingBlocState_success extends GeneratingBlocState {}

///
/// BLOC
///
class GeneratingBloc extends Bloc<GeneratingBlocEvent, GeneratingBlocState> {
  final BananaProService bananaProService;
  final PredictionDbRepository predictionDbRepository;

  GeneratingBloc({
    required this.bananaProService,
    required this.predictionDbRepository,
  }) : super(GeneratingBlocState_initial()) {
    ///
    /// GeneratingBlocEvent_generatePrediction
    ///
    on<GeneratingBlocEvent_generatePrediction>((event, emit) async {
      final Completer completer = Completer();
      try {
        emit(GeneratingBlocState_generating());

        // await Future.delayed(Duration(seconds: 5));

        final response = await bananaProService.generateBabyPrediction(
          ultrasoundImage: event.ultrasoundImage,
          fatherImage: event.fatherImage,
          motherImage: event.motherImage,
          gestationWeek: event.gestationWeek,
          gender: event.gender,
          additionalNotes: event.additionalNotes,
        );
        logger.f(response);
        if (response != null) {
          emit(GeneratingBlocState_generated(generatedImage: response));
          add(
            GeneratingBlocEvent_saveGeneratePredictionImage(
              user: event.user!,
              imageBytes: response,
              gestationWeek: event.gestationWeek,
              gender: event.gender,
            ),
          );
        } else {
          emit(GeneratingBlocState_error());
        }
      } catch (e) {
        logger.e(e);
      }
    });

    ///
    /// GeneratingBlocEvent_saveGeneratePredictionImage
    ///
    on<GeneratingBlocEvent_saveGeneratePredictionImage>((event, emit) async {
      try {
        logger.d("SAVE GENERATED PREDICTION IMAGE");

        // 1. save  file and get download url
        final downloadUrl = await predictionDbRepository
            .saveUint8ListImageInFirebaseStorage(
              imageBytes: event.imageBytes,
              currentUser: event.user,
            );

        // 2. generate entity
        final PredictionEntity prediction = PredictionEntity(
          id: Uuid().v4().substring(0, 8),
          created: DateTime.now(),
          ownerId: event.user.uid,
          photoUrl: downloadUrl,
          gestationWeek: event.gestationWeek,
          gender: event.gender ?? "",
        );

        // 3. save entity
        await predictionDbRepository.savePrediction(prediction: prediction);
      } catch (e) {
        logger.e(e);
      }
    });
  }
}
