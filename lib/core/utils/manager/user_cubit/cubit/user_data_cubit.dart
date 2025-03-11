import 'dart:convert';

import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/core/utils/model/user_model.dart';
import 'package:UpDown/core/utils/secure_storage.dart';
import 'package:UpDown/core/utils/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserDataInitial());

  UserModel? userData;

  Future<void> loadUserData({required User user}) async {
    if (userData != null) {
      emit(UserDataSuccess(userData!));
      return;
    }
    if (user.id.isEmpty) {
      emit(UserDataError(error: "المستخدم غير موجود."));
      return;
    }

    emit(UserDataLoading());

    final storedUser = await gitIt.get<SecureStorage>().get("user_data");
    if (storedUser != null) {
      userData = UserModel.fromJson(jsonDecode(storedUser));
      emit(UserDataSuccess(userData!));
      return;
    }

    final result = await gitIt.get<ApiService>().getUserData(user: user);

    result.fold(
      (errMsg) => emit(UserDataError(error: errMsg.errMessage)),
      (response) {
        userData = response;
        emit(UserDataSuccess(response));
      },
    );
  }

  void reset() {
    userData = null;
    emit(UserDataInitial());
  }
}
