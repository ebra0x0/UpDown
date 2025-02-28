import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/core/utils/model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserDataInitial());

  UserModel? userData;

  Future<void> loadUserData({required User user}) async {
    try {
      emit(UserDataLoading());

      if (user.id.isEmpty) {
        emit(UserDataError(error: "المستخدم غير صالح"));
        return;
      }

      final result = await ApiService.getUserData(user: user);

      result.fold(
        (errMsg) => emit(UserDataError(error: errMsg)),
        (response) {
          userData = response;
          emit(UserDataSuccess(response));
        },
      );
    } catch (e) {
      emit(UserDataError(error: "حدث خطأ غير متوقع : $e"));
    }
  }
}
