import 'dart:async';
import 'dart:developer';
import 'package:UpDown/core/network/api/api_constants.dart';
import 'package:UpDown/core/network/api/api_failure/api_failures.dart';
import 'package:UpDown/core/network/network_manager.dart';
import 'package:UpDown/core/utils/helper/safe_request.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApiInitializer {
  static SupabaseClient? _client;
  static bool _isInitializing = false;
  static StreamSubscription? _netSub;
  final NetworkManager _networkManager;

  ApiInitializer(this._networkManager);

  SupabaseClient get client {
    if (_client == null) {
      throw CustomFailure('Api is not initialized.');
    }
    return _client!;
  }

  Future<void> start() async {
    if (_isInitializing || _client != null) return;

    if (_networkManager.isConnected) {
      await _init();
    } else {
      _netSub = _networkManager.connectionStream.listen((isConnected) async {
        if (isConnected && _client == null) {
          await _init();
          await _dispose();
        }
      });
    }
  }

  Future<void> _init() async {
    try {
      _isInitializing = true;
      final Supabase supabase = await safeRequest(
          networkManager: _networkManager,
          request: () => Supabase.initialize(
                url: ApiConstants.baseUrl,
                anonKey: ApiConstants.apiKey,
              ));
      _client = supabase.client;
      _isInitializing = false;
    } catch (e) {
      _isInitializing = false;
      log(e.toString());
    }
  }

  void ensureInitialized() {
    if (_client != null) return;

    throw 'Cannot connect to the server.';
  }

  static Future<void> _dispose() async {
    await _netSub?.cancel();
    _netSub = null;
  }
}
