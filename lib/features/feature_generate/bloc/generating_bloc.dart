// ignore_for_file: camel_case_types

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:baby_look/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:baby_look/features/feature_gallery/bloc/predictions_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' show Image;
import 'package:uuid/uuid.dart';

import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_exception/app_exception.dart';
import 'package:baby_look/features/feature_generate/data/banana_pro_service.dart';
import 'package:baby_look/features/feature_generate/domain/prediction_db_repository.dart';
import 'package:baby_look/features/feature_generate/domain/prediction_entity.dart';
import 'package:baby_look/features/feature_user/bloc/user_bloc.dart';
import 'package:baby_look/features/feature_user/domain/repo/user_db_repository.dart';
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

class GeneratingBlocState_error extends GeneratingBlocState {
  final AppException error;
  GeneratingBlocState_error({required this.error});
  @override
  List<Object?> get props => [error];
}

class GeneratingBlocState_success extends GeneratingBlocState {}

///
/// BLOC
///
class GeneratingBloc extends Bloc<GeneratingBlocEvent, GeneratingBlocState> {
  final BananaProService bananaProService;
  final PredictionDbRepository predictionDbRepository;
  final UserBloc userBloc;
  final UserDbRepository userDbRepository;
  final AuthBloc authBloc;
  final PredictionsBloc predictionsBloc;
  GeneratingBloc({
    required this.bananaProService,
    required this.predictionDbRepository,
    required this.userBloc,
    required this.userDbRepository,
    required this.authBloc,
    required this.predictionsBloc,
  }) : super(GeneratingBlocState_initial()) {
    ///
    /// GeneratingBlocEvent_generatePrediction
    ///
    on<GeneratingBlocEvent_generatePrediction>((event, emit) async {
      //  final Completer completer = Completer();

      try {
        //1) check this user verified or not
        final authState = authBloc.state;

        if (authState is AuthBlocState_authenticated) {
          if (authState.verifiedUser) {
            final userBlocState = userBloc.state;
            //2) check balance
            if (userBlocState is UserBlocState_loaded) {
              final isEnoughtBalance = await userDbRepository.haveEnoughCoin(
                coinPrice: AppConstant.REQUEST_PRICE,
                user: userBlocState.userEntity,
              );

              //2.1) if enoughtBalance
              if (isEnoughtBalance) {
                // update balance
                await userDbRepository.updateUserCoin(
                  coinPrice: AppConstant.REQUEST_PRICE,
                  user: userBlocState.userEntity,
                );

                //3) start generating
                emit(GeneratingBlocState_generating());

                // SEND REQUEST TO AI
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
                  // save image
                  add(
                    GeneratingBlocEvent_saveGeneratePredictionImage(
                      user: event.user!,
                      imageBytes: response,
                      gestationWeek: event.gestationWeek,
                      gender: event.gender,
                    ),
                  );

                   // reload predcitions
                  predictionsBloc.add(PredictionsBlocEvent_loadPredictions());
                  userBloc.add(UserBlocEvent_reloadUser());
                } else {
                  throw AppException.invalid_response;
                }
              } else {
                throw AppException.balance_not_enought;
              }
            }
          } else {
            throw AppException.account_unverified;
          }
        }

        // await Future.delayed(Duration(seconds: 5));
      } catch (e) {
        logger.e(e);
        emit(GeneratingBlocState_error(error: e as AppException));
      } finally {
        emit(GeneratingBlocState_initial());
       
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
