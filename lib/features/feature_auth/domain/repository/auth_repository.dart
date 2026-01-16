import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<void> authViaLoginPassword({
    required String login,
    required String password,
  });

  Future<void> authViaGoogle();
  Future<UserCredential> authViaFacebook();

  Future<User?> getCurrentUser();

  Future<void> authViaGithub();

  Future<void> logOut();

  Stream<User?> userStream();
}
