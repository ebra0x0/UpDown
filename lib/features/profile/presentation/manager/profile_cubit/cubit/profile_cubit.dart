import 'package:UpDown/core/utils/model/profile_model.dart';
import 'package:UpDown/features/profile/data/repos/profile_repo.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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

    final res = await _repo.call();
    res.fold(
      (failure) => emit(ProfileError(failure.errMessage)),
      (profile) {
        if (profile == null) {
          emit(ProfileEmpty());
          return;
        }
        this.profile = profile;
        emit(ProfileLoaded(profile));
      },
    );
  }

  Future<void> updateAvatar(XFile file) async {
    await _repo.updateAvatar(file).fold(
          (f) => emit(AvatarError(f.errMessage, profile: profile!)),
          (_) => null,
        );
  }
}
