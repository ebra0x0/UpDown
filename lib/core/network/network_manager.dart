import 'dart:async';
import 'dart:developer';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:rxdart/rxdart.dart';

class NetworkManager {
  static final _controller = BehaviorSubject<bool>.seeded(true);
  static StreamSubscription? _internetSubscription;
  bool isConnected = true;
  static bool isInitialized = false;
  final InternetConnection _connectionChecker;

  NetworkManager(this._connectionChecker) {
    log("NetworkManager initialized");
    init();
  }

  Stream<bool> get connectionStream => _controller.stream;

  void init() {
    if (isInitialized) return;
    try {
      _controller.add(isConnected);
      isInitialized = true;
      _internetSubscription = _connectionChecker.onStatusChange.listen(
        (status) {
          isConnected = status == InternetStatus.connected;
          _controller.add(isConnected);
        },
        onError: (e) => log('NetworkManager error: $e'),
      );
    } catch (e) {
      log('Failed to initialize NetworkManager: $e');
      rethrow;
    }
  }

  static void dispose() async {
    try {
      _internetSubscription?.cancel();
      await _controller.close();
      _internetSubscription = null;
      isInitialized = false;
    } catch (e) {
      log('Failed to dispose NetworkManager: $e');
    }
  }
}
