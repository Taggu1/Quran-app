import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quran_app_clean_architecture/src/core/entities/ayah.dart';

class NetWorkInfo {
  final InternetConnectionChecker internetConnectionChecker;

  NetWorkInfo({required this.internetConnectionChecker});

  Future<bool> isConnected() async {
    return await internetConnectionChecker.hasConnection;
  }
}
