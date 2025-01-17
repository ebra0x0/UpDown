part of 'previous_reports_cubit_cubit.dart';

sealed class PreviousReportsCubitState {}

final class PreviousReportsCubitInitial extends PreviousReportsCubitState {}

final class PreviousReportsCubitLoading extends PreviousReportsCubitState {}

final class PreviousReportsCubitSuccess extends PreviousReportsCubitState {
  final List<ReportModel> reportsList;
  PreviousReportsCubitSuccess({required this.reportsList});
}

final class PreviousReportsCubitError extends PreviousReportsCubitState {
  final String error;
  PreviousReportsCubitError({required this.error});
}
