import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkManager {
  static final _controller = StreamController<bool>.broadcast();
  static late final StreamSubscription _internetSubscription;
  static bool isConnected = false;
  static bool isInitialized = false;

  static void init() {
    if (isInitialized) return;
    isInitialized = true;
    _internetSubscription =
        InternetConnectionChecker.instance.onStatusChange.listen((status) {
      isConnected = status == InternetConnectionStatus.connected;
      _controller.add(isConnected);
    });
  }

  static Stream<bool> get connectionStream => _controller.stream;

  static void dispose() {
    _internetSubscription.cancel();
    _controller.close();
  }
}
