import 'package:UpDown/features/auth/manager/auth_cubit.dart';

abstract class AuthRedirectStrategy {
  String? redirect(String currentPath, AuthStatus status);
}
