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
      final response = await ApiService.getUserData(user: user);

      if (response == null) throw Exception("User data not found");

      userData = response;
      emit(UserDataSuccess(response));
    } on Exception catch (e) {
      emit(UserDataError(error: e.toString()));
    }
  }
}
