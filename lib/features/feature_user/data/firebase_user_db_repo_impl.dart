import 'package:baby_look/features/feature_generate/domain/prediction_entity.dart';
import 'package:baby_look/features/feature_user/data/user_model.dart';
import 'package:baby_look/features/feature_user/domain/repo/user_db_repository.dart';
import 'package:baby_look/features/feature_user/domain/user_entity.dart';
import 'package:baby_look/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserDbRepoImpl implements UserDbRepository {
  final _db = FirebaseFirestore.instance.collection('USER');

  @override
  Future<void> firstTimeSetup({required User user}) async {
    try {
      logger.d('First time setup for new user ${user.uid}');
      final userId = user.uid;
      final UserEntity userEntity = UserEntity(
        id: userId,
        coins: 1,
        predictions: [],
        favourites: [],
      );

      await saveUser(user: userEntity);
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Future<bool> isNewUser({required UserCredential userCredential}) async {
    return userCredential.additionalUserInfo?.isNewUser ?? false;
  }

  @override
  Future<void> saveUser({required UserEntity user}) async {
    try {
      logger.d("SAVE USER ${user.id}");
      final userModel = UserModel.fromEntity(user);
      await _db.doc(user.id).set(userModel.toMap());
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Future<UserEntity> getUserEntityFromUid({required String uid}) async {
    try {
      final snapshot = await _db.doc(uid).get();

      final data = snapshot.data();

      logger.d(data);

      final userModel = UserModel.fromMap(data!);
      return userModel.toEntity();
    } catch (e) {
      logger.e(e);
      throw 'FAILED TO USER ENTITY';
    }
  }

  @override
  Future<void> likeOrUnlikePrediction({
    required UserEntity? user,
    required PredictionEntity prediction,
  }) async {
    try {
      if (user != null) {
        final userEntity = await getUserEntityFromUid(uid: user.id);
        final userModel = UserModel.fromEntity(userEntity);
        if (userEntity.favourites.contains(prediction.id)) {
          logger.d('REMOVE FROM FAVOURITE');
          // REMOVE
          final updatedList = userEntity.favourites;
          updatedList.remove(prediction.id);

          // updated model
          final updatedModel = userModel.copyWith(favourites: updatedList);
          await updateUser(user: updatedModel.toEntity());
        } else {
          logger.d('ADD  TO FAVOURITE');
          // ADD
          final updatedList = userEntity.favourites;
          updatedList.add(prediction.id);
          // updated model
          final updatedModel = userModel.copyWith(favourites: updatedList);
          await updateUser(user: updatedModel.toEntity());
        }
      }
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Future<void> updateUser({required UserEntity user}) async {
    try {
      logger.d("UPDATED USER");
      await _db.doc(user.id).update(UserModel.fromEntity(user).toMap());
    } catch (e) {
      logger.e(e);
    }
  }
}

