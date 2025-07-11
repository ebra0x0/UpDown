import 'package:UpDown/core/network/api_constants.dart';
import 'package:UpDown/core/network/api_failure.dart';
import 'package:UpDown/core/utils/helper/safe_request.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApiInitializer {
  static SupabaseClient? _client;

  static SupabaseClient get client {
    if (_client == null) {
      throw Exception('Supabase client is not initialized');
    }
    return _client!;
  }

  static Future<void> init() async {
    if (_client != null) return;

    try {
      await safeRequest(
          request: () => Supabase.initialize(
                url: ApiConstants.baseUrl,
                anonKey: ApiConstants.apiKey,
              ));
      _client = Supabase.instance.client;
    } on NetworkFailure catch (e) {
      throw NetworkFailure(e.errMessage);
    } catch (e) {
      throw CustomFailure("فشل الاتصال");
    }
  }

  static void dispose() {
    _client?.dispose();
  }
}
