part of 'active_reports_cubit.dart';

sealed class ActiveReportsCubitState {}

final class ActiveReportsCubitInitial extends ActiveReportsCubitState {}

final class ActiveReportsCubitLoading extends ActiveReportsCubitState {}

final class ActiveReportsCubitSuccess extends ActiveReportsCubitState {
  final List<ReportModel> reportsList;
  ActiveReportsCubitSuccess({required this.reportsList});
}

final class ActiveReportsCubitError extends ActiveReportsCubitState {
  final String error;
  ActiveReportsCubitError({required this.error});
}
