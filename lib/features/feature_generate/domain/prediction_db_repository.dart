import 'dart:typed_data';

import 'package:baby_look/features/feature_generate/domain/prediction_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class PredictionDbRepository {
  // SAVE RETURNED UINT8LIST IMAGE FROM AI IN FIREBASE STORAGE AND RETURN DOWNLOAD LINK
  Future<String> saveUint8ListImageInFirebaseStorage({
    required Uint8List? imageBytes,
    required User currentUser,
  });

  Future<void> savePrediction({required PredictionEntity prediction});

  Future<List<PredictionEntity>> getPredictionListByUid({required String uid});

  Future<List<PredictionEntity>> getPredictionFavouriteListByUid({required String uid});

  Future<void> deletePrediction({required PredictionEntity prediction});
}
