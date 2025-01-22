part of 'buildings_cubit.dart';

sealed class BuildingsCubitState {}

final class BuildingsCubitInitial extends BuildingsCubitState {}

final class BuildingsCubitLoading extends BuildingsCubitState {}

final class BuildingsCubitSuccess extends BuildingsCubitState {
  final List<BuildingModel> buildings;
  BuildingsCubitSuccess({required this.buildings});
}

final class BuildingsCubitEmpty extends BuildingsCubitState {
  BuildingsCubitEmpty();
}

final class BuildingsCubitError extends BuildingsCubitState {
  final String error;
  BuildingsCubitError({required this.error});
}
