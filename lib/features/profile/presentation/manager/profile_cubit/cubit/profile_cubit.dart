import 'dart:convert';

import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/core/utils/model/profile_model.dart';
import 'package:UpDown/core/utils/secure_storage.dart';
import 'package:UpDown/core/utils/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  ProfileModel? profile;

  Future<void> fetchUserData({required User user}) async {
    if (profile != null) {
      emit(ProfileLoaded(profile!));
      return;
    }

    emit(ProfileLoading());

    final localData = await fetchLocalData();
    if (localData != null) {
      profile = localData;
      emit(ProfileLoaded(localData));
      return;
    }

    final remoteData = await fetchRemoteData(user);
    if (remoteData != null) {
      profile = remoteData;
      emit(ProfileLoaded(remoteData));
    }
  }

  Future<ProfileModel?> fetchLocalData() async {
    final storedUser = await gitIt.get<SecureStorage>().get("user_data");
    if (storedUser != null) {
      return ProfileModel.fromJson(jsonDecode(storedUser));
    }
    return null;
  }

  Future<ProfileModel?> fetchRemoteData(User user) async {
    final result = await gitIt.get<ApiService>().fetchProfile(user.id);
    return result.fold((failure) => null, (user) => user);
  }

  // Future<void> createNewUser() async {
  //   final result = await gitIt.get<ApiService>().createNewUser();
  //   result.fold((failure) => null, (user) => user);
  // }
  void clearUserData() {
    gitIt.get<SecureStorage>().delete("user_data");
    profile = null;
    emit(ProfileInitial());
  }
}
