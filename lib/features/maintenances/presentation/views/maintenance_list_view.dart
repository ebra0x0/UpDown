import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/features/maintenances/presentation/cubit/maintenance_cubit.dart';
import 'package:UpDown/features/maintenances/presentation/widgets/maintenance_list_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaintenanceListView extends StatefulWidget {
  const MaintenanceListView({super.key});

  @override
  State<MaintenanceListView> createState() => _MaintenanceListViewState();
}

class _MaintenanceListViewState extends State<MaintenanceListView> {
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
