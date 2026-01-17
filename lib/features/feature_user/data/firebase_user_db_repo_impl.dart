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
}
