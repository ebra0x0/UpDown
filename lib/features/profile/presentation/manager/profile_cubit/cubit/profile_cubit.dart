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

    final ProfileResponseModel? localData = await _repo.callLocal();

    if (localData != null) {
      _profile = localData;
      emit(state.copyWith(
        status: ContentStatus.loaded,
        profile: localData,
      ));
      return;
    }

    final res = await _repo.callRemote();

    res.fold(
      (failure) {
        if (localData == null) {
          emit(state.copyWith(status: ContentStatus.error));
        }
      },
      (remoteData) async {
        if (remoteData != null && remoteData != localData) {
          _repo.save(remoteData);
          emit(state.copyWith(
            status: ContentStatus.loaded,
            profile: remoteData,
          ));
        }
      },
    );
  }

  Future<void> updateProfile(ProfileRequestModel profile) async {
    await _repo.update(profile).fold(
          (f) => emit(state.copyWith(isAvatarUpdateFailed: true)),
          (_) => emit(state.copyWith(isAvatarUpdateFailed: false)),
        );
  }
}
