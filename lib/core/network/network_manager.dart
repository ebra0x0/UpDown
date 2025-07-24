import 'dart:async';
import 'dart:developer';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkManager {
  static final _controller = StreamController<bool>.broadcast();
  static StreamSubscription? _internetSubscription;
  bool isConnected = true;
  static bool isInitialized = false;
  final InternetConnectionChecker _connectionChecker;

  NetworkManager(this._connectionChecker) {
    init();
  }

  Stream<bool> get connectionStream => _controller.stream;

  void init() {
    if (isInitialized) return;
    try {
      isInitialized = true;
      _checkInitialConnection();
      _internetSubscription = _connectionChecker.onStatusChange.listen(
        (status) {
          isConnected = status == InternetConnectionStatus.connected;
          _controller.add(isConnected);
        },
        onError: (e) => log('NetworkManager error: $e'),
      );
    } catch (e) {
      log('Failed to initialize NetworkManager: $e');
      rethrow;
    }
  }

  Future<void> _checkInitialConnection() async {
    isConnected = await _connectionChecker.hasConnection;
    _controller.add(isConnected);
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
