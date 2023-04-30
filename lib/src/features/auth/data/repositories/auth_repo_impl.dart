import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repo.dart';
import '../data_sources/auth_local_data_source.dart';
import '../data_sources/auth_remote_data_source.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthLocalDataSource authLocalDataSource;
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepoImpl(
      {required this.authLocalDataSource, required this.authRemoteDataSource});
  @override
  Future<Either<Failure, AppUser>> fetchUserDataFromStorage() async {
    try {
      final user = await authLocalDataSource.fetchUserFromStorage();
      return Right(user);
    } on EmptyCasheException {
      return Left(EmptyCasheFailure());
    }
  }

  @override
  Future<Either<Failure, AppUser>> logInUserWithThirdParty(
      {required ThirdParty thirdPartyType}) async {
    try {
      final user = await authRemoteDataSource.loginUserWithThirdParty(
          thirdPartyType: thirdPartyType);
      authLocalDataSource.saveUserData(appUser: user, fromThirdParty: true);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseAuthFaliure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      final response = await authRemoteDataSource.signOut();
      authLocalDataSource.removeUserData();
      return Right(response);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseAuthFaliure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, AppUser>> signUpOrLoginAsAGuest() async {
    try {
      final user = await authRemoteDataSource.signUpOrLoginAsAGuest();
      authLocalDataSource.saveUserData(appUser: user);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseAuthFaliure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, AppUser>> signUpOrLoginWithEmailAndPassword(
      {required String email,
      required String password,
      required bool isLogin}) async {
    try {
      final user =
          await authRemoteDataSource.signUpOrLoginUserWithEmailAndPassword(
        email: email,
        password: password,
        isLogin: isLogin,
      );
      authLocalDataSource.saveUserData(appUser: user);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseAuthFaliure(message: e.message!));
    }
  }
}
