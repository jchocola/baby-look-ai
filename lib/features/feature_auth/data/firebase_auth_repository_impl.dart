import 'package:baby_look/features/feature_auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepositoryImpl  implements AuthRepository{
  @override
  Future<UserCredential> authViaFacebook() {
    // TODO: implement authViaFacebook
    throw UnimplementedError();
  }

  @override
  Future<void> authViaGithub() {
    // TODO: implement authViaGithub
    throw UnimplementedError();
  }

  @override
  Future<void> authViaGoogle() {
    // TODO: implement authViaGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> authViaLoginPassword({required String login, required String password}) {
    // TODO: implement authViaLoginPassword
    throw UnimplementedError();
  }

}