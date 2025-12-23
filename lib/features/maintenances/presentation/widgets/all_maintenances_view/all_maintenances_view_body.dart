import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/theme/app_skeleton.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/widgets/screen_echo.dart';
import 'package:UpDown/features/maintenances/presentation/cubit/maintenance_cubit.dart';
import 'package:UpDown/features/maintenances/presentation/cubit/maintenance_state.dart';
import 'package:UpDown/features/maintenances/presentation/widgets/maintenance_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaintenanceListViewBody extends StatelessWidget {
  const MaintenanceListViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return _ListViewBuilder();
  }
}

class _ListViewBuilder extends StatelessWidget {
  const _ListViewBuilder();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaintenanceCubit, MaintenanceState>(
      buildWhen: (previous, current) =>
          previous.maintenances != current.maintenances,
      builder: (context, state) {
        if (state.maintenances!.isEmpty) {
          return ScreenEcho(
            message: "لا توجد صيانات حتى الآن",
          );
        }
        return AppSkeletonizer(
          enabled: state.status == ContentStatus.loading,
          child: ListView.builder(
            padding: AppInsets.h4,
            itemCount: state.maintenances!.length,
            itemBuilder: (context, index) {
              final maintenance = state.maintenances![index];
              return Padding(
                padding: AppInsets.bottom4,
                child: MaintenanceCard(maintenance: maintenance),
              );
            },
          ),
        );
      },
    );
  }
}
