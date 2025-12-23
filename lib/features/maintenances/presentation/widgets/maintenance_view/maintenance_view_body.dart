import 'package:UpDown/core/widgets/custom_sliver_app_bar.dart';
import 'package:UpDown/features/maintenances/presentation/widgets/maintenance_view/maintenance_view_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MaintenanceViewBody extends StatelessWidget {
  const MaintenanceViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CustomSliverAppBar(title: 'تفاصيل الصيانة'),
        MaintenanceViewBuilder(),
      ],
    );
  }
}
