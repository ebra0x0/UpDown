part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<BuildingSummary> buildingsSummary;
  HomeLoaded({required this.buildingsSummary});
}

final class HomeEmpty extends HomeState {}

final class HomeError extends HomeState {
  final String error;
  HomeError({required this.error});
}
