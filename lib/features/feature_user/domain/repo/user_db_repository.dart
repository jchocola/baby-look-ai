import 'package:baby_look/features/feature_user/domain/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserDbRepository {
  Future<void> firstTimeSetup({required User user});

  Future<void> saveUser({required UserEntity user});

  Future<UserEntity> getUserEntityFromUid({required String uid});

  Future<bool> isNewUser({required UserCredential userCredential});
}
