import 'package:UpDown/core/utils/enums/enums.dart';

abstract class AuthRedirectStrategy {
  String? redirect(String currentPath, AuthStatus status);
}
