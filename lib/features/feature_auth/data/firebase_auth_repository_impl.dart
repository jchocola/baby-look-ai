import 'package:baby_look/features/feature_auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FirebaseAuthRepositoryImpl  implements AuthRepository{
  @override
  Future<UserCredential> authViaFacebook() async{
    // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();
  // Create a credential from the access token
  final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);
   // Once signed in, return the UserCredential
  return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
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