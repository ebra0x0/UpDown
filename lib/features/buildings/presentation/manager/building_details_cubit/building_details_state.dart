part of 'building_details_cubit.dart';

sealed class BuildingDetailsState {}

final class BuildingDetailsInitial extends BuildingDetailsState {}

final class BuildingDetailsLoading extends BuildingDetailsState {}

final class BuildingDetailsLoaded extends BuildingDetailsState {
  final BuildingModel building;
  BuildingDetailsLoaded({required this.building});
}

final class BuildingDetailsError extends BuildingDetailsState {
  final String error;
  BuildingDetailsError({required this.error});
}

final class BuildingDetailsEmpty extends BuildingDetailsState {}
