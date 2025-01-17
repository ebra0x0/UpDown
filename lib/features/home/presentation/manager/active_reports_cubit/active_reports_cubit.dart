import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/core/utils/model/report_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'active_reports_cubit_state.dart';

class ActiveReportsCubit extends Cubit<ActiveReportsCubitState> {
  ActiveReportsCubit() : super(ActiveReportsCubitInitial());

  List<ReportModel> reports = [];

  Future<void> fetchActiveReports() async {
    try {
      emit(ActiveReportsCubitLoading());
      final List<ReportModel> activeReports =
          await ApiService().getActiveReports();
      reports = activeReports;
      emit(ActiveReportsCubitSuccess(reportsList: activeReports));
    } catch (e) {
      emit(ActiveReportsCubitError(error: e.toString()));
    }
  }
}
