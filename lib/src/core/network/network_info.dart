import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetWorkInfo {
  Future<bool> isConnected();
}

class NetWorkInfoInternetConnectionCheckerImpl extends NetWorkInfo {
  final InternetConnectionChecker internetConnectionChecker;

  NetWorkInfoInternetConnectionCheckerImpl(
      {required this.internetConnectionChecker});

  @override
  Future<bool> isConnected() async {
    return await internetConnectionChecker.hasConnection;
  }
}

class NetWorkInfoWebImbl extends NetWorkInfo {
  @override
  Future<bool> isConnected() async {
    return Future.value(true);
  }
}
