import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repo.dart';

abstract class AuthRemoteDataSource {
  Future<AppUser> loginUserWithThirdParty({required ThirdParty thirdPartyType});
  Future<AppUser> signUpOrLoginUserWithEmailAndPassword({
    required String email,
    required String password,
    required bool isLogin,
  });
  Future<AppUser> signUpOrLoginAsAGuest();
  Future<Unit> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl(
      {required this.firebaseAuth, required this.googleSignIn});
  @override
  Future<AppUser> loginUserWithThirdParty(
      {required ThirdParty thirdPartyType}) {
    switch (thirdPartyType) {
      case ThirdParty.google:
        return _logInUserWithGoogle();
      default:
        return _logInUserWithGoogle();
    }
  }

  @override
  Future<Unit> signOut() async {
    await firebaseAuth.signOut();
    return unit;
  }

  @override
  Future<AppUser> signUpOrLoginAsAGuest() async {
    final userCredential = await firebaseAuth.signInAnonymously();
    final user = AppUser(userId: userCredential.user!.uid);
    return user;
  }

  @override
  Future<AppUser> signUpOrLoginUserWithEmailAndPassword(
      {required String email,
      required String password,
      required bool isLogin}) async {
    UserCredential? credential;
    if (isLogin) {
      credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } else {
      credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    }
    final user = AppUser(userId: credential.user!.uid);
    return user;
  }

  Future<AppUser> _logInUserWithGoogle() async {
    googleSignIn.signOut();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final AppUser user = AppUser(userId: credential.accessToken!);
    return user;
  }
}
