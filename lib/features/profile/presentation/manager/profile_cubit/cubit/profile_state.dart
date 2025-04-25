part of 'profile_cubit.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final ProfileModel? userDataModel;

  ProfileLoaded(this.userDataModel);
}

final class ProfileError extends ProfileState {
  final String error;

  ProfileError({required this.error});
}

final class ProfileNew extends ProfileState {
  final ProfileModel? user;

  ProfileNew(this.user);
}

final class ProfileLoading extends ProfileState {}
