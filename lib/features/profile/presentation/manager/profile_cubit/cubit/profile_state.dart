part of 'profile_cubit.dart';

class ProfileState {
  final ProfileResponseModel? profile;
  final String? errorMsg;
  final ContentStatus status;
  final bool isAvatarUpdateFailed;

  const ProfileState({
    this.profile,
    this.errorMsg,
    this.status = ContentStatus.initial,
    this.isAvatarUpdateFailed = false,
  });

  ProfileState copyWith({
    ProfileResponseModel? profile,
    String? errorMsg,
    ContentStatus? status,
    bool? isAvatarUpdateFailed,
  }) =>
      ProfileState(
        profile: profile ?? this.profile,
        errorMsg: errorMsg ?? this.errorMsg,
        status: status ?? this.status,
        isAvatarUpdateFailed: isAvatarUpdateFailed ?? this.isAvatarUpdateFailed,
      );
}
