import 'package:UpDown/core/theme/app_icons.dart';
import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/theme/app_radius.dart';
import 'package:UpDown/core/theme/app_skeleton.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/extensions/icon_ext.dart';
import 'package:UpDown/core/utils/models/technician_model.dart';
import 'package:UpDown/features/buildings/presentation/cubits/buildings_cubit/buildings_cubit.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevators_cubit/elevators_cubit.dart';
import 'package:UpDown/features/maintenance/data/models/maintenanace_model.dart';
import 'package:UpDown/features/maintenance/data/models/maintenance_view_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MaintenanceCard extends StatefulWidget {
  final MaintenanceViewModel maintenance;
  const MaintenanceCard({super.key, required this.maintenance});

  @override
  State<MaintenanceCard> createState() => _MaintenanceCardState();
}

class _MaintenanceCardState extends State<MaintenanceCard> {
  MaintenanceModel get maintenance => widget.maintenance.data;
  TechnicianModel get technician => widget.maintenance.technician;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: AppRadius.borderRadius12,
      ),
      padding: AppInsets.all16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TitleAndPrice(title: maintenance.type.title, cost: maintenance.cost),
          const SizedBox(height: 12),
          _BuildingAndElevator(
              buildingId: maintenance.buildingId,
              elevatorId: maintenance.elevatorId),
          const SizedBox(height: 16),
          _TechnicianAndStatus(
            maintenanceStatus: maintenance.status,
            technicianName: technician.name,
          ),
        ],
      ),
    );
  }
}

class _BuildingAndElevator extends StatelessWidget {
  final String buildingId;
  final String elevatorId;

  const _BuildingAndElevator({
    required this.buildingId,
    required this.elevatorId,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _BuildingBuilder(buildingId: buildingId),
        const SizedBox(width: 8),
        _ElevatorBuilder(elevatorId: elevatorId),
      ],
    );
  }
}

class _ElevatorBuilder extends StatelessWidget {
  const _ElevatorBuilder({
    required this.elevatorId,
  });

  final String elevatorId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElevatorsCubit, ElevatorsState>(
      builder: (context, state) {
        final String? elevatorName = state.elevators
            ?.firstWhereOrNull(
              (elevator) => elevator.id == elevatorId,
            )
            ?.name;

        return AppSkeletonizer(
          enabled: state.status == ContentStatus.loading,
          child: _InfoChip(
              label: elevatorName ?? " ",
              icon: AppIcons.elevatorIcon.copyWith(
                color: AppTheme.primary,
                size: 18.sp,
              )),
        );
      },
    );
  }
}

class _BuildingBuilder extends StatelessWidget {
  const _BuildingBuilder({
    required this.buildingId,
  });

  final String buildingId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuildingsCubit, BuildingsState>(
      builder: (context, state) {
        final String? buildingName = state.buildings
            ?.firstWhereOrNull(
              (building) => building.id == buildingId,
            )
            ?.name;

        return AppSkeletonizer(
          enabled: state.status == ContentStatus.loading,
          child: _InfoChip(
              label: buildingName ?? " ",
              icon: AppIcons.apartmentIcon.copyWith(
                color: AppTheme.primary,
                size: 18.sp,
              )),
        );
      },
    );
  }
}

class _TechnicianAndStatus extends StatelessWidget {
  const _TechnicianAndStatus({
    required this.maintenanceStatus,
    required this.technicianName,
  });

  final MaintenanceStatus maintenanceStatus;
  final String technicianName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "اسم الفني : $technicianName",
          style: AppTextStyles.textStyle14,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        Text(
          maintenanceStatus.title,
          style: AppTextStyles.textStyle14.copyWith(
            color: maintenanceStatus.color,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}

class _TitleAndPrice extends StatelessWidget {
  const _TitleAndPrice({
    required this.title,
    required this.cost,
  });

  final String title;
  final int cost;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.textStyle18,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          "$cost جم",
          style: AppTextStyles.textStyle18.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final Icon icon;

  const _InfoChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 4),
        Text(
          label,
          style: AppTextStyles.textStyle12,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}
