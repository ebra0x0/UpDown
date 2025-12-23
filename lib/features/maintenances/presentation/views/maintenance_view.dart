import 'package:UpDown/features/maintenances/presentation/cubit/maintenance_cubit.dart';
import 'package:flutter/material.dart';
import 'package:UpDown/features/maintenances/presentation/widgets/maintenance_view/maintenance_view_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaintenanceView extends StatefulWidget {
  final String maintenanceId;
  const MaintenanceView({super.key, required this.maintenanceId});

  @override
  State<MaintenanceView> createState() => _MaintenanceViewState();
}

class _MaintenanceViewState extends State<MaintenanceView> {
  @override
  void initState() {
    super.initState();
    context.read<MaintenanceCubit>().selectMaintenance(widget.maintenanceId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaintenanceViewBody(),
    );
  }
}
