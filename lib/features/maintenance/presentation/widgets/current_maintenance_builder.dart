import 'package:UpDown/core/theme/app_skeleton.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/widgets/header_section.dart';
import 'package:UpDown/features/maintenance/data/models/maintenanace_model.dart';
import 'package:UpDown/features/maintenance/presentation/cubit/maintenance_cubit.dart';
import 'package:UpDown/features/maintenance/presentation/cubit/maintenance_state.dart';
import 'package:UpDown/features/maintenance/presentation/widgets/maintenance_card.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentMaintenanceBuilder extends StatelessWidget {
  const CurrentMaintenanceBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaintenanceCubit, MaintenanceState>(
      builder: (context, state) {
        final isLoading = state.status == ContentStatus.loading;
        final hasData = state.currentMaintenance != null;

        return AppSkeletonizer(
          isSliver: true,
          enabled: isLoading,
          child: SliverList(
            delegate: SliverChildListDelegate(
              [
                if (isLoading || hasData)
                  HeaderSection(
                    title: "الصيانة الحالية",
                    titleStyle: AppTextStyles.textStyle18,
                    actionText: "عرض الكل",
                    onActionTap: () {},
                  ),
                if (isLoading || hasData)
                  MaintenanceCard(
                    maintenance:
                        state.currentMaintenance ?? MaintenanceModel.empty(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
