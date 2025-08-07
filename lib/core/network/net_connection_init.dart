import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

InternetConnection internetConnectionInit() {
  return InternetConnection.createInstance(
    checkInterval: Duration(seconds: 2),
    customCheckOptions: [
      InternetCheckOption(uri: Uri.parse('https://www.google.com')),
      InternetCheckOption(uri: Uri.parse('https://www.facebook.com')),
    ],
  );
}
