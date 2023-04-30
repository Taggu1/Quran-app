import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../auth/domain/entities/user.dart';
import '../../domain/entities/user_progress.dart';
import '../models/user_progress_model.dart';

abstract class UserProgressRemoteDataSource {
  Future<UserProgress> fetchUserProgress({required AppUser appUser});

  Future<Unit> updateUserProgress({
    required AppUser appUser,
    required UserProgressModel userProgressData,
  });
}

class UserProgressRemoteDataSourceImpl extends UserProgressRemoteDataSource {
  final FirebaseFirestore db;

  UserProgressRemoteDataSourceImpl({required this.db});

  @override
  Future<UserProgress> fetchUserProgress({required AppUser appUser}) async {
    final userRef = db.collection("users").doc(appUser.userId);
    DocumentSnapshot userdoc = await userRef.get();
    final userData = userdoc.data();
    print(userData);
    // TODO: Implument if null feature
    if (userData == null) {
      _dealsWithIfUserDataIsNull(userRef: userRef);
      return const UserProgressModel(daysStreak: 0, totalDays: 0);
    } else {
      return UserProgressModel.fromFireStore(userData as Map<String, dynamic>);
    }
  }

  @override
  Future<Unit> updateUserProgress(
      {required AppUser appUser, required UserProgressModel userProgressData}) {
    db
        .collection("users")
        .doc(appUser.userId)
        .update(userProgressData.toFireStore());
    return Future.value(unit);
  }

  void _dealsWithIfUserDataIsNull({required DocumentReference userRef}) {
    final UserProgressModel userProgress = const UserProgressModel(
      daysStreak: 0,
      totalDays: 0,
    );

    userRef.set(userProgress.toFireStore());
  }
}
