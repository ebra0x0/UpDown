import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/core/utils/model/auth_user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_cubit_state.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  LoginCubit() : super(LoginCubitInitial());

  Future<void> login(AuthUserModel user) async {
    emit(LoginCubitLoading());
    try {
      await ApiService().signInWithPassword(user);
      emit(LoginCubitSuccess());
    } on AuthException catch (e) {
      emit(LoginCubitError(error: e.message));
    }
  }
}
