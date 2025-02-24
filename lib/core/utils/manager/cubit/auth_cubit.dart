import 'package:UpDown/core/utils/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthStateInitial());

  void authMonitor() {
    ApiService.supabase.auth.onAuthStateChange.listen((event) {
      switch (event.event) {
        case AuthChangeEvent.signedIn:
          emit(AuthStateAuthenticated(user: event.session!.user));

        case AuthChangeEvent.signedOut:
          emit(AuthStateUnAuthenticated());

        case AuthChangeEvent.initialSession:
          if (event.session != null) {
            emit(AuthStateAuthenticated(user: event.session!.user));
            break;
          } else {
            emit(AuthStateUnAuthenticated());
          }

        default:
          emit(AuthStateUnAuthenticated());
      }
    });
  }
}
