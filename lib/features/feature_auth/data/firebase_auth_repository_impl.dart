import 'package:baby_look/core/app_exception/app_exception.dart';
import 'package:baby_look/features/feature_auth/domain/repository/auth_repository.dart';
import 'package:baby_look/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<UserCredential> authViaFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.accessToken?.tokenString == null) {
        throw AppException.failed_auth_via_facebook;
      }

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);
      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      logger.e(e);
      if (e.code == "account-exists-with-different-credential")
        throw AppException.account_exists_with_different_credential;
      if (e.code == "invalid-credential") throw AppException.invalid_credential;
      if (e.code == "operation-not-allowed")
        throw AppException.operation_not_allowed;
      if (e.code == "user-disabled") throw AppException.user_disabled;
      if (e.code == "user-not-found") throw AppException.user_not_found;
      if (e.code == "wrong-password") throw AppException.wrong_password;
      if (e.code == "invalid-verification-code")
        throw AppException.invalid_verification_code;
      if (e.code == "invalid-verification-id")
        throw AppException.invalid_verification_id;

      throw AppException.failed_auth_via_facebook;
    }
  }

  @override
  Future<void> authViaGithub() async {
    try {
      // Create a new provider
      GithubAuthProvider githubProvider = GithubAuthProvider();
      await _auth.signInWithProvider(githubProvider);
    } on FirebaseAuthException catch (e) {
      logger.e(e);
      if (e.code == "user-disabled") throw AppException.user_disabled;
      throw AppException.failed_auth_via_github;
    }
  }

  @override
  Future<void> authViaGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn.instance
          .authenticate();

      if (googleUser?.authentication == null) {
        throw AppException.failed_auth_via_google;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = googleUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      logger.e(e);
      if (e.code == "account-exists-with-different-credential")
        throw AppException.account_exists_with_different_credential;
      if (e.code == "invalid-credential") throw AppException.invalid_credential;
      if (e.code == "operation-not-allowed")
        throw AppException.operation_not_allowed;
      if (e.code == "user-disabled") throw AppException.user_disabled;
      if (e.code == "user-not-found") throw AppException.user_not_found;
      if (e.code == "wrong-password") throw AppException.wrong_password;
      if (e.code == "invalid-verification-code")
        throw AppException.invalid_verification_code;
      if (e.code == "invalid-verification-id")
        throw AppException.invalid_verification_id;

      throw AppException.failed_auth_via_google;
    }
  }

  @override
  Future<void> authViaLoginPassword({
    required String login,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: login, password: password);
    } on FirebaseAuthException catch (e) {
      logger.e(e);
      if (e.code == "invalid-email") throw AppException.invalid_email;
      if (e.code == "user-disabled") throw AppException.user_disabled;
      if (e.code == "user-not-found") throw AppException.user_not_found;

      if (e.code == "wrong-password") throw AppException.wrong_password;

      if (e.code == "too-many-requests") throw AppException.too_many_requests;
      if (e.code == "user-token-expired") throw AppException.user_token_expired;
      if (e.code == "network-request-failed")
        throw AppException.network_request_failed;
      if (e.code == "invalid-credential") throw AppException.invalid_credential;
      if (e.code == "operation-not-allowed")
        throw AppException.operation_not_allowed;
      throw AppException.failed_auth_via_login_password;
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  @override
  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Stream<User?> userStream() {
    return _auth.authStateChanges();
  }

  @override
  Future<UserCredential?> registerNewUser({
    required String login,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: login,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      logger.e(e);

      if (e.code == "email-already-in-use")
        throw AppException.email_already_in_use;
      if (e.code == "invalid-email") throw AppException.invalid_email;
      if (e.code == "operation-not-allowed")
        throw AppException.operation_not_allowed;
      if (e.code == "weak-password") throw AppException.weak_password;
      if (e.code == "too-many-requests") throw AppException.too_many_requests;
      if (e.code == "user-token-expired") throw AppException.user_token_expired;
      if (e.code == "network-request-failed")
        throw AppException.network_request_failed;
      if (e.code == "operation-not-allowed")
        throw AppException.operation_not_allowed;

      throw AppException.failed_register_user;
    }
  }

  @override
  Future<void> authWithUserCredential({
    required UserCredential userCredential,
  }) async {
    try {
      // await _auth.signInWithCredential(userCredential)
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Future<void> sendVerifyEmail({required User user}) async {
    try {
      if (!user.emailVerified && user.phoneNumber == null) {
        await user.sendEmailVerification();
        logger.d('Sended email verify to ${user.email}');
      } else {
        logger.d('This user verified or signed via telephone');
      }
    } catch (e) {
      logger.e(e);
      throw AppException.failed_verify_email;
    }
  }

  @override
  Future<void> sendPasswordRecoveyEmail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      logger.d('Sended paswword recover  email to ${email}');
    } on FirebaseAuthException catch (e) {
      logger.e(e.code);
      if (e.code == "auth/invalid-email") throw AppException.auth_invalid_email;
      if (e.code == "auth/missing-android-pkg-name")
        throw AppException.auth_missing_android_pkg_name;
      if (e.code == "auth/missing-continue-uri")
        throw AppException.auth_missing_continue_uri;
      if (e.code == "auth/missing-ios-bundle-id")
        throw AppException.auth_missing_ios_bundle_id;
      if (e.code == "auth/user-not-found")
        throw AppException.auth_user_not_found;

      throw AppException.failed_recovery_password_email;
    }
  }
}
