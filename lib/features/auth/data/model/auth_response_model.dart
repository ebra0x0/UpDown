import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthResponseModel {
  final Session? session;
  final User? user;
  final AuthStatus status;

  AuthResponseModel({
    this.session,
    this.user,
    this.status = AuthStatus.unAuthenticated,
  });

  factory AuthResponseModel.fromAuthState(AuthState authState) {
    {
      return AuthResponseModel(
        session: authState.session,
        user: authState.session?.user,
      );
    }
  }

  factory AuthResponseModel.fromAuthResponse(AuthResponse authRes) {
    return AuthResponseModel(
      session: authRes.session,
      user: authRes.user,
    );
  }

  Map<String, dynamic> toJson() => {
        'session': session?.toJson(),
        'user': user?.toJson(),
        'status': status.index,
      };

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      session:
          json['session'] != null ? Session.fromJson(json['session']) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      status: AuthStatus.values[json['status'] ?? 0],
    );
  }

  AuthResponseModel copyWith({
    Session? session,
    User? user,
    AuthStatus? status,
  }) {
    return AuthResponseModel(
      session: session ?? this.session,
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }
}
