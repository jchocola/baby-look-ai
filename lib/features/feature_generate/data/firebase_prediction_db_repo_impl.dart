// ignore_for_file: unused_element

import 'dart:io';
import 'dart:typed_data';

import 'package:baby_look/features/feature_generate/data/prediction_model.dart';
import 'package:baby_look/features/feature_generate/domain/prediction_db_repository.dart';
import 'package:baby_look/features/feature_generate/domain/prediction_entity.dart';
import 'package:baby_look/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebasePredictionDbRepoImpl implements PredictionDbRepository {
  final _db = FirebaseFirestore.instance.collection('PREDICTIONS');
  final _storageRef = FirebaseStorage.instance.ref();
  @override
  Future<void> deletePrediction({required PredictionEntity prediction}) async {
    try {
      await _db.doc(prediction.id).delete();
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Future<List<PredictionEntity>> getPredictionListByUid({required String uid}) {
    // TODO: implement getPredictionListByUid
    throw UnimplementedError();
  }

  @override
  Future<void> savePrediction({required PredictionEntity prediction}) async {
    try {
      final predictionModel = PredictionModel.fromEntity(prediction);

      await _db.doc(predictionModel.id).set(predictionModel.toMap());
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Future<String> saveUint8ListImageInFirebaseStorage({
    required Uint8List? imageBytes,
    required User currentUser,
  }) async {
    try {
      if (imageBytes == null) {
        throw 'EMOTY DATA';
      }

      /// [uid]/[datetime].png

      final uid = currentUser.uid;
      final photoName = DateTime.now().millisecondsSinceEpoch.toString();
      final fullname = "$uid/$photoName.png";

      // create ref
      final spaceRef = _storageRef.child(fullname);

      // prepare file
      final file = _convertByteToFile(imageBytes);

      // save file to storage
      await spaceRef.putFile(file);

      // return download url
      return await spaceRef.getDownloadURL();
      
    } catch (e) {
      logger.e(e);
      throw 'Failed to save image';
    }
  }

  File _convertByteToFile(Uint8List bytes) {
    return File.fromRawPath(bytes);
  }
}
