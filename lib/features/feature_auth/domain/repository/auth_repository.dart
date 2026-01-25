import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<UserCredential> authViaLoginPassword({
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

  Future<UserCredential> authViaGoogle();
  Future<UserCredential> authViaFacebook();

  Future<User?> getCurrentUser();

  Future<UserCredential> authViaGithub();

  Future<UserCredential> authViaTwitter();

  Future<void> logOut();

  Stream<User?> userStream();

  Future<String?> getVerificationPhoneNumberId({required String phoneNumber});
  Future<PhoneAuthCredential> verifySMSCode({
    required String smsCode,
    required String? verificationId,
  });
  Future<UserCredential> signInWithPhoneAuthCredential({
    required PhoneAuthCredential credential,
  });
}
