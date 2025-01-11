import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/features/auth/data/auth_user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'registraion_cubit_state.dart';

class RegistrationCubit extends Cubit<RegistraionCubitState> {
  RegistrationCubit() : super(RegistraionCubitInitial());

  Future<void> signUp(AuthUserModel user) async {
    emit(RegistraionCubitLoading());
    try {
      await ApiService().signUp(user);
      emit(RegistraionCubitSuccess());
    } catch (e) {
      emit(RegistraionCubitError());
    }
  }
}
