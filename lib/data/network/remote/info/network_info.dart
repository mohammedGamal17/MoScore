import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImplement implements NetworkInfo {
  final InternetConnectionChecker _internetConnectionChecker;

  NetworkInfoImplement(this._internetConnectionChecker);

  @override
  Future<bool> get isConnected => _internetConnectionChecker.hasConnection;
  var isDeviceConnected = false;
}
