import 'package:flutter/material.dart';
import 'package:UpDown/features/maintenance/presentation/widgets/maintenance_view_body.dart';

class MaintenanceView extends StatelessWidget {
  const MaintenanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaintenanceViewBody(),
    );
  }
}
