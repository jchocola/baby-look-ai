// ignore_for_file: camel_case_types

import 'package:baby_look/core/domain/save_to_gallery_repository.dart';
import 'package:baby_look/core/domain/share_image_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:baby_look/features/feature_generate/domain/prediction_db_repository.dart';
import 'package:baby_look/features/feature_generate/domain/prediction_entity.dart';
import 'package:baby_look/main.dart';

///
/// EVENT
///
abstract class PredictionsBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PredictionsBlocEvent_loadPredictions extends PredictionsBlocEvent {
  final User? user;
  PredictionsBlocEvent_loadPredictions({this.user});
  @override
  List<Object?> get props => [user];
}

class PredictionsBlocEvent_saveImageFromServerToGallery
    extends PredictionsBlocEvent {
  final PredictionEntity? prediction;
  PredictionsBlocEvent_saveImageFromServerToGallery({this.prediction});
  @override
  List<Object?> get props => [prediction];
}

class PredictionsBlocEvent_shareImageFromServerToGallery
    extends PredictionsBlocEvent {
  final PredictionEntity? prediction;
  PredictionsBlocEvent_shareImageFromServerToGallery({this.prediction});
  @override
  List<Object?> get props => [prediction];
}

///
/// STATE
///
abstract class PredictionsBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PredictionsBlocState_init extends PredictionsBlocState {}

class PredictionsBlocState_loading extends PredictionsBlocState {}

class PredictionsBlocState_loaded extends PredictionsBlocState {
  final List<PredictionEntity> predictionList;
  final List<PredictionEntity> favouriteList;
  PredictionsBlocState_loaded({
    required this.predictionList,
    required this.favouriteList,
  });
  @override
  List<Object?> get props => [predictionList, favouriteList];
}

class PredictionsBlocState_error extends PredictionsBlocState {}

///
/// BLOC
///
class PredictionsBloc extends Bloc<PredictionsBlocEvent, PredictionsBlocState> {
  final PredictionDbRepository predictionDbRepository;
  final SaveToGalleryRepository saveToGalleryRepository;
  final ShareImageRepository shareImageRepository;
  PredictionsBloc({
    required this.predictionDbRepository,
    required this.saveToGalleryRepository,
    required this.shareImageRepository,
  }) : super(PredictionsBlocState_init()) {
    ///
    /// PredictionsBlocEvent_loadPredictions
    ///
    on<PredictionsBlocEvent_loadPredictions>((event, emit) async {
      try {
        logger.d('Load predictions by ${event.user?.uid}');
        if (event.user != null) {
          final predictionList = await predictionDbRepository
              .getPredictionListByUid(uid: event.user!.uid);
          final favoritePredictionList = await predictionDbRepository
              .getPredictionFavouriteListByUid(uid: event.user!.uid);

          logger.d('Prediction list : ${predictionList.length}');

          emit(
            PredictionsBlocState_loaded(
              predictionList: predictionList,
              favouriteList: favoritePredictionList,
            ),
          );
        } else {
          logger.d('Empty User');
          emit(
            PredictionsBlocState_loaded(predictionList: [], favouriteList: []),
          );
        }
      } catch (e) {
        logger.e(e);
        emit(
          PredictionsBlocState_loaded(predictionList: [], favouriteList: []),
        );
      }
    });

    ///
    /// PredictionsBlocEvent_saveImageFromServerToGallery
    ///
    on<PredictionsBlocEvent_saveImageFromServerToGallery>((event, emit) async {
      try {
        logger.d("PredictionsBlocEvent_saveImageFromServerToGallery Tapped");
        await saveToGalleryRepository.saveInterImageToGallery(
          imageUrl: event.prediction?.photoUrl ?? '',
        );
      } catch (e) {
        logger.e(e);
      }
    });

    ///
    /// PredictionsBlocEvent_shareImageFromServerToGallery
    ///
    on<PredictionsBlocEvent_shareImageFromServerToGallery>((event, emit) async {
      try {
        logger.d("PredictionsBlocEvent_shareImageFromServerToGallery Tapped");
        await shareImageRepository.shareImage(
          imageUrl: event.prediction?.photoUrl ?? '',
        );
      } catch (e) {
        logger.e(e);
      }
    });
  }
}
