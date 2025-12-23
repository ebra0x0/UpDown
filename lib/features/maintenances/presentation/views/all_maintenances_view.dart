import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/features/maintenances/presentation/cubit/maintenance_cubit.dart';
import 'package:UpDown/features/maintenances/presentation/widgets/all_maintenances_view/all_maintenances_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllMaintenancesView extends StatefulWidget {
  const AllMaintenancesView({super.key});

  @override
  State<AllMaintenancesView> createState() => _AllMaintenancesViewState();
}

class _AllMaintenancesViewState extends State<AllMaintenancesView> {
  @override
  void initState() {
    super.initState();
    context.read<MaintenanceCubit>().fetchAllMaintenances();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("قائمة الصيانات", style: AppTextStyles.textStyle22)),
        body: MaintenanceListViewBody());
  }
}
