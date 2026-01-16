import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<void> authViaLoginPassword({
    required String login,
    required String password,
  });

  Future<void> authViaGoogle();
  Future<UserCredential> authViaFacebook();

  Future<void> authViaGithub();
}
