import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/keys.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/user.dart';

abstract class AuthLocalDataSource {
  Future<AppUser> fetchUserFromStorage();
  Future<Unit> saveUserData({required AppUser appUser, bool? fromThirdParty});
  Future<Unit> removeUserData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<AppUser> fetchUserFromStorage() async {
    final userId = sharedPreferences.getString(uidKey);
    final userIdToken = sharedPreferences.getString(idTokenKey);

    if (userId == null && userIdToken == null) {
      throw EmptyCasheException();
    } else if (userId == null) {
      return AppUser(userId: idTokenKey);
    } else {
      return AppUser(userId: userId);
    }
  }

  @override
  Future<Unit> removeUserData() {
    sharedPreferences.remove(idTokenKey);
    sharedPreferences.remove(uidKey);
    return Future.value(unit);
  }

  @override
  Future<Unit> saveUserData(
      {required AppUser appUser, bool? fromThirdParty}) async {
    if (fromThirdParty == null) {
      sharedPreferences.setString(idTokenKey, appUser.userId);
    } else {
      sharedPreferences.setString(uidKey, appUser.userId);
    }

    return Future.value(unit);
  }
}
