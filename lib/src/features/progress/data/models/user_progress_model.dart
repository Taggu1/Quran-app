import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user_progress.dart';

class UserProgressModel extends UserProgress {
  const UserProgressModel(
      {required super.daysStreak, required super.totalDays});

  factory UserProgressModel.fromFireStore(Map<String, dynamic> json) {
    return UserProgressModel(
      daysStreak: json["daysStreak"],
      totalDays: json["totalDays"],
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      "daysStreak": daysStreak,
      "totalDays": totalDays,
    };
  }
}
