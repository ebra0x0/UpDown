import 'package:UpDown/core/utils/model/report_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'previous_reports_cubit_state.dart';

class PreviousReportsCubit extends Cubit<PreviousReportsCubitState> {
  PreviousReportsCubit() : super(PreviousReportsCubitInitial());
}
