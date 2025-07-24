import 'package:internet_connection_checker/internet_connection_checker.dart';

InternetConnectionChecker internetConnectionCheckerInit() {
  return InternetConnectionChecker.createInstance(
      checkInterval: Duration(seconds: 2),
      addresses: [
        AddressCheckOption(
            uri: Uri.parse('https://www.google.com'),
            timeout: Duration(seconds: 3)),
        AddressCheckOption(
            uri: Uri.parse('https://www.facebook.com'),
            timeout: Duration(seconds: 3)),
      ],
      checkTimeout: Duration(seconds: 3),
      slowConnectionConfig: SlowConnectionConfig(
        enableToCheckForSlowConnection: true,
      ));
}
