part of 'profile_cubit.dart';

class ProfileState {
  final ProfileResponseModel? profile;
  final String? errorMsg;
  final ContentStatus status;

  const ProfileState({
    this.profile,
    this.errorMsg,
    this.status = ContentStatus.initial,
  });

  ProfileState copyWith({
    ProfileResponseModel? profile,
    String? errorMsg,
    ContentStatus? status,
  }) =>
      ProfileState(
        profile: profile ?? this.profile,
        errorMsg: errorMsg ?? this.errorMsg,
        status: status ?? this.status,
      );
}
