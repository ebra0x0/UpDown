import 'dart:async';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/profile/data/model/profile_request_model.dart';
import 'package:UpDown/features/profile/data/model/profile_response_model.dart';
import 'package:UpDown/features/profile/data/repos/profile_repo.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _repo;

  ProfileResponseModel? _profile;
  StreamSubscription? _streamSubscription;
  ProfileCubit(this._repo) : super(ProfileState());

  Future<void> call() async {
    if (state.status == ContentStatus.loading) return;

    if (_profile != null) {
      emit(state.copyWith(
        status: ContentStatus.loaded,
        profile: _profile,
      ));
      return;
    }

    emit(state.copyWith(status: ContentStatus.loading));

    _streamSubscription = _repo.call().listen((profileRes) {
      profileRes.fold((failure) {
        emit(state.copyWith(
          status: ContentStatus.error,
          errorMsg: failure.errMessage,
        ));
      }, (data) {
        _profile = data;
        emit(state.copyWith(
          status: ContentStatus.loaded,
          profile: data,
        ));
      });
    }, onError: (e) {
      emit(state.copyWith(
        status: ContentStatus.error,
        errorMsg: "تعذر تحميل بيانات الملف الشخصي",
      ));
    });
  }

  Future<void> updateProfile(ProfileRequestModel profile) async {
    await _repo.update(profile).fold(
        (f) => emit(state.copyWith(isAvatarUpdateFailed: true)), (success) {
      emit(state.copyWith(
        status: ContentStatus.updated,
        isAvatarUpdateFailed: false,
      ));
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
