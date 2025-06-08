import 'package:UpDown/core/utils/model/profile_model.dart';
import 'package:UpDown/features/profile/data/repos/profile_repo.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._repo) : super(ProfileInitial());

  ProfileModel? profile;
  final ProfileRepo _repo;

  Future<void> call() async {
    if (profile != null) {
      emit(ProfileLoaded(profile!));
      return;
    }

    emit(ProfileLoading());

    final ProfileModel? localData = await _repo.callLocal();
    if (localData != null) {
      profile = localData;
      emit(ProfileLoaded(profile!));
    }

    final res = await _repo.callRemote();

    res.fold(
      (failure) {
        if (localData == null) emit(ProfileError(failure.errMessage));
      },
      (remoteData) async {
        if (remoteData != null && remoteData != localData) {
          _repo.save(remoteData);
          emit(ProfileLoaded(remoteData));
        }
      },
    );
  }

  Future<void> updateProfile(ProfileModel profile) async {
    await _repo.update(profile).fold(
          (f) => emit(AvatarError(f.errMessage, profile: profile)),
          (_) => null,
        );
  }
}
