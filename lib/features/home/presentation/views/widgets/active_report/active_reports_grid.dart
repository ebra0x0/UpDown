import 'package:UpDown/features/home/presentation/manager/active_reports_cubit/active_reports_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'active_reports_box.dart';

class ActiveReportsGrid extends StatelessWidget {
  const ActiveReportsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActiveReportsCubit(),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 2 / 3),
        itemBuilder: (context, index) => ActiveReportsBox(),
      ),
    );
  }
}
