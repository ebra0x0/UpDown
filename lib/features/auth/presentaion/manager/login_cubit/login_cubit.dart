import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/core/utils/service_locator.dart';
import 'package:UpDown/features/auth/data/model/auth_user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_cubit_state.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  LoginCubit() : super(LoginCubitInitial());

  Future<void> login(AuthUserModel user) async {
    emit(LoginCubitLoading());

    final signIn = await gitIt.get<ApiService>().signInWithPassword(user);
    signIn.fold((failure) => emit(LoginCubitError(error: failure.errMessage)),
        (success) => emit(LoginCubitSuccess()));
  }
}
