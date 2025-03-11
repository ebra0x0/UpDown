import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/core/utils/service_locator.dart';
import 'package:UpDown/features/auth/data/model/auth_user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'registraion_cubit_state.dart';

class RegistrationCubit extends Cubit<RegistraionCubitState> {
  RegistrationCubit() : super(RegistraionCubitInitial());

  Future<void> signUp(AuthUserModel user) async {
    emit(RegistraionCubitLoading());

    final signUp = await gitIt.get<ApiService>().signUp(user);
    signUp.fold(
        (failure) => emit(RegistraionCubitError(error: failure.errMessage)),
        (success) => emit(RegistraionCubitSuccess()));
  }
}
