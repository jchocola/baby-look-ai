import 'package:baby_look/features/feature_auth/domain/repository/auth_repository.dart';
import 'package:baby_look/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<UserCredential> authViaFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.accessToken == null) {
      throw 'Failed to auth via facebook';
    }

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);
    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  @override
  Future<void> authViaGithub() async {
    try {
      // Create a new provider
      GithubAuthProvider githubProvider = GithubAuthProvider();
      await _auth.signInWithProvider(githubProvider);
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Future<void> authViaGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn.instance
        .authenticate();

    if (googleUser?.authentication == null) {
      throw 'Failed to auth via google';
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await _auth.signInWithCredential(credential);
  }

  @override
  Future<void> authViaLoginPassword({
    required String login,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: login, password: password);
    } catch (e) {
      logger.e(e);
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
    } catch (e) {
      logger.e(e);
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
    }
  }

  @override
  Future<void> sendPasswordRecoveyEmail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
       logger.d('Sended paswword recover  email to ${email}');
    } catch (e) {
      logger.e(e);
    }
  }
}
