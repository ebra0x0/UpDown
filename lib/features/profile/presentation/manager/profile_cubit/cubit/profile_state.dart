part of 'profile_cubit.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final ProfileModel profile;

  ProfileLoaded(this.profile);
}

final class ProfileError extends ProfileState {
  final String error;

  ProfileError(this.error);
}

final class ProfileEmpty extends ProfileState {}

final class ProfileNew extends ProfileState {
  final ProfileModel? user;

  ProfileNew(this.user);
}

final class ProfileLoading extends ProfileState {}

final class AvatarError extends ProfileState {
  final ProfileModel profile;
  final String error;

  AvatarError(this.error, {required this.profile});
}
