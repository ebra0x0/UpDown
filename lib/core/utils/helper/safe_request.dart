import 'package:UpDown/core/network/api_failure.dart';
import 'package:retry/retry.dart';
import 'dart:async';
import 'dart:io';

Future<T> safeRequest<T>({
  required Future<T> Function() request,
  String errorMessage = "فشل الاتصال . حاول مرة أخرى.",
}) async {
  final retryOptions = RetryOptions(maxAttempts: 3);

  try {
    return await retryOptions.retry(
        () => request().timeout(const Duration(seconds: 6)),
        retryIf: (e) => e is SocketException || e is TimeoutException);
  } catch (_) {
    throw NetworkFailure(errorMessage);
  }
}
