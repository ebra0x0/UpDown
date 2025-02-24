part of 'user_data_cubit.dart';

sealed class UserDataState {}

final class UserDataInitial extends UserDataState {}

final class UserDataSuccess extends UserDataState {
  final UserModel? userDataModel;

  UserDataSuccess(this.userDataModel);
}

final class UserDataError extends UserDataState {
  final String error;

  UserDataError({required this.error});
}

final class UserDataLoading extends UserDataState {}
