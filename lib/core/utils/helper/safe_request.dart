import 'package:UpDown/core/network/api/api_failure/api_failures.dart';
import 'package:UpDown/core/network/network_manager.dart';
import 'package:retry/retry.dart';
import 'dart:async';
import 'dart:io';

Future<T> safeRequest<T>({
  required Future<T> Function() request,
  required NetworkManager networkManager,
  Duration timeoutDuration = const Duration(seconds: 6),
  String errorMessage = "هناك مشكلة في الاتصال",
}) async {
  final retryOptions = RetryOptions(
    maxAttempts: 3,
    delayFactor: const Duration(seconds: 2),
  );

  final bool isConnected = networkManager.isConnected;

  if (!isConnected) {
    throw NetworkFailure(errorMessage);
  }

  return await retryOptions.retry(() => request().timeout(timeoutDuration),
      retryIf: (e) => e is SocketException || e is TimeoutException);
}
