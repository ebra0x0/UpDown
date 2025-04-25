part of 'buildings_cubit.dart';

sealed class BuildingsState {}

final class BuildingsInitial extends BuildingsState {}

final class BuildingsLoading extends BuildingsState {}

final class BuildingsLoaded extends BuildingsState {
  final List<BuildingSummaryModel> buildings;
  BuildingsLoaded({required this.buildings});
}

final class BuildingsEmpty extends BuildingsState {
  BuildingsEmpty();
}

final class BuildingsError extends BuildingsState {
  final String error;
  BuildingsError({required this.error});
}
