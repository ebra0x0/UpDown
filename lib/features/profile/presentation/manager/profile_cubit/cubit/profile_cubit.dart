import 'dart:async';
import 'dart:developer';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/profile/data/model/profile_request_model.dart';
import 'package:UpDown/features/profile/data/model/profile_response_model.dart';
import 'package:UpDown/features/profile/data/repos/profile_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _repo;

  ProfileResponseModel? _profile;
  StreamSubscription? _streamSubscription;
  ProfileCubit(this._repo) : super(const ProfileState());

  Future<void> call() async {
    if (state.status == ContentStatus.loading || _streamSubscription != null) {
      return;
    }

    if (_profile != null) {
      emit(state.copyWith(
        status: ContentStatus.loaded,
        profile: _profile,
      ));
      return;
    }

    emit(state.copyWith(status: ContentStatus.loading));

    _streamSubscription = _repo.call().listen((profileRes) {
      if (isClosed) return;
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
          errorMsg: null,
        ));
      });
    }, onError: (e) {
      log(e.toString());
      if (state.status != ContentStatus.error) {
        emit(state.copyWith(
          status: ContentStatus.error,
          errorMsg: "تعذر تحميل بيانات الملف الشخصي",
        ));
      }
    });
  }

  Future<void> updateProfile(ProfileRequestModel profile) async {
    if (state.status == ContentStatus.updating) return;
    emit(state.copyWith(status: ContentStatus.updating));
    final res = await _repo.update(profile);
    if (isClosed) return;
    res.fold(
        (f) => emit(
              state.copyWith(
                  status: ContentStatus.error, errorMsg: f.errMessage),
            ), (success) {
      emit(state.copyWith(
        status: ContentStatus.updated,
        errorMsg: null,
      ));
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
