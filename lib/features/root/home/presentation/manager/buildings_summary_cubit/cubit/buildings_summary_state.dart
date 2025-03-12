part of 'buildings_summary_cubit.dart';

sealed class BuildingsSummaryState {}

final class BuildingsSummaryInitial extends BuildingsSummaryState {}

final class BuildingsSummaryLoading extends BuildingsSummaryState {}

final class BuildingsSummaryLoaded extends BuildingsSummaryState {
  final List<BuildingSummaryModel> buildingsSummary;
  BuildingsSummaryLoaded({required this.buildingsSummary});
}

final class BuildingsSummaryEmpty extends BuildingsSummaryState {}

final class BuildingsSummaryError extends BuildingsSummaryState {
  final String error;
  BuildingsSummaryError({required this.error});
}
