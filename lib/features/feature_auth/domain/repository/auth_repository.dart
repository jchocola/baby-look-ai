import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<void> authViaLoginPassword({
    required String login,
    required String password,
  });

  Future<UserCredential?> registerNewUser({
    required String login,
    required String password,
  });

  Future<void> sendVerifyEmail({required User user});

    Future<void> sendPasswordRecoveyEmail({required String email});

  Future<void> authWithUserCredential({required UserCredential userCredential});

  Future<void> authViaGoogle();
  Future<UserCredential> authViaFacebook();

  Future<User?> getCurrentUser();

  Future<void> authViaGithub();

  Future<void> logOut();

  Stream<User?> userStream();
}
