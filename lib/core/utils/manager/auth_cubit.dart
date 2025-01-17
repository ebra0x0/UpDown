import 'package:UpDown/core/utils/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial()) {
    _monitorAuthState();
  }

  void _monitorAuthState() {
    ApiService().supabase.auth.onAuthStateChange.listen((event) {
      if (event.event == AuthChangeEvent.signedIn) {
        emit(AuthSignedIn(user: event.session!.user));
      } else {
        emit(AuthSignedOut());
      }
    });
  }
}
