// ignore_for_file: camel_case_types

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' show Image;
import 'package:uuid/uuid.dart';

import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_exception/app_exception.dart';
import 'package:baby_look/core/bloc/app_config_bloc.dart';
import 'package:baby_look/core/domain/save_to_gallery_repository.dart';
import 'package:baby_look/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:baby_look/features/feature_gallery/bloc/predictions_bloc.dart';
import 'package:baby_look/features/feature_generate/data/banana_pro_service.dart';
import 'package:baby_look/features/feature_generate/domain/prediction_db_repository.dart';
import 'package:baby_look/features/feature_generate/domain/prediction_entity.dart';
import 'package:baby_look/features/feature_notification/domain/local_notifcation_repository.dart';
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

class GeneratingBlocEvent_showNotificationAfterGenerating
    extends GeneratingBlocEvent {
  final String title;
  final String body;
  GeneratingBlocEvent_showNotificationAfterGenerating({
    required this.title,
    required this.body,
  });

  @override
  List<Object?> get props => [title, body];
}

class GeneratingBlocEvent_saveImageByteToGallery extends GeneratingBlocEvent {
  final Uint8List imageBytes;
  GeneratingBlocEvent_saveImageByteToGallery({required this.imageBytes});

  @override
  List<Object?> get props => [imageBytes];
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

class GeneratingBlocState_success extends GeneratingBlocState {
  final String success;
  GeneratingBlocState_success({required this.success});
  @override
  List<Object?> get props => [success];
}

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
  final AppConfigBloc appConfigBloc;
  final SaveToGalleryRepository saveToGalleryRepository;
  final LocalNotifcationRepository localNotifcationRepository;
  GeneratingBloc({
    required this.bananaProService,
    required this.predictionDbRepository,
    required this.userBloc,
    required this.userDbRepository,
    required this.authBloc,
    required this.predictionsBloc,
    required this.appConfigBloc,
    required this.localNotifcationRepository,
    required this.saveToGalleryRepository,
  }) : super(GeneratingBlocState_initial()) {
    ///
    /// GeneratingBlocEvent_generatePrediction
    ///
    on<GeneratingBlocEvent_generatePrediction>((event, emit) async {
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
                // logger.f(response); // NEVER USE THIS LINE , THIS WILL BLOCK UI THREAD

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

                  await Future.delayed(Duration(seconds: 2), () {
                    // reload predcitions
                    predictionsBloc.add(PredictionsBlocEvent_loadPredictions());
                    userBloc.add(UserBlocEvent_reloadUser());
                  });
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
        // emit(GeneratingBlocState_initial()); // DONT USE THIS , ALLOW USE CAN SAVE TO GALLERY
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

    ///
    /// SHOW NOTIFICATION AFTER GENERATING IMAGE
    ///
    on<GeneratingBlocEvent_showNotificationAfterGenerating>((
      event,
      emit,
    ) async {
      final appConfigBlocState = appConfigBloc.state;
      if (appConfigBlocState is AppConfigBlocState_loaded) {
        // get notifcation setting setting
        final notificationEnability = appConfigBlocState.notificationEnability;

        if (notificationEnability) {
          localNotifcationRepository.showNotification(
            title: event.title,
            body: event.body,
            channel_id: AppConstant.NOTIFICATION_CHANNEL_ID,
            channel_name: AppConstant.NOTIFICATION_CHANNEL_ID,
          );
        }
      }
    });

    ///
    /// GeneratingBlocEvent_saveImageByteToGallery
    ///
    on<GeneratingBlocEvent_saveImageByteToGallery>((event, emit) async {
      try {
        final currentState = state;
        logger.d('Start save to gallery');
        final imageDir = await saveToGalleryRepository.saveImageBytesToGallery(
          imageBytes: event.imageBytes,
        );

        emit(GeneratingBlocState_success(success: imageDir));
        emit(currentState);
      } catch (e) {
        logger.e(e);
      }
    });
  }
}
