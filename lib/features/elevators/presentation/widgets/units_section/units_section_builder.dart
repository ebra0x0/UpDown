import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/widgets/header_section.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevators_cubit/elevators_cubit.dart';
import 'package:UpDown/features/elevators/presentation/widgets/units_section/units_section.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:UpDown/core/theme/app_skeleton.dart';

class SliverUnitsSectionBuilder extends StatelessWidget {
  const SliverUnitsSectionBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElevatorsCubit, ElevatorsState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          final units = state.currentElevator?.units ?? [];
          return SliverPadding(
            padding: AppInsets.h8,
            sliver: AppSkeletonizer(
              isSliver: true,
              enabled: state.status == ContentStatus.loading,
              child: SliverList(
                  delegate: SliverChildListDelegate([
                Visibility(
                  visible: units.isNotEmpty,
                  child: HeaderSection(
                    title: "الوحدات",
                    titleStyle: AppTextStyles.textStyle18,
                  ),
                ),
                UnitsSection(
                  units: units,
                ),
              ])),
            ),
          );
        });
  }
}
