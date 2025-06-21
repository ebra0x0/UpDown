import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/widgets/screen_echo.dart';
import 'package:UpDown/features/elevators/data/models/unit_model.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevator_units_cubit/elevator_units_cubit.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevator_details_units_section/elevator_details_units_section.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SliverUnitsSectionBuilder extends StatelessWidget {
  const SliverUnitsSectionBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElevatorUnitsCubit, ElevatorUnitsState>(
      builder: (context, state) {
        if (state.status == ContentStatus.error) {
          return SliverToBoxAdapter(
            child: ScreenEcho(message: state.errorMsg!),
          );
        }

        return Skeletonizer.sliver(
            enabled: state.status == ContentStatus.loading,
            child: ElevatorDetailsUnitSection(
              units: state.status == ContentStatus.loaded
                  ? state.units!
                  : List.generate(5, (_) => UnitModel.empty()),
            ));
      },
    );
  }
}
