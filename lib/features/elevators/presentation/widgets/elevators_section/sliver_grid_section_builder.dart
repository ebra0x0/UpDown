import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/widgets/screen_echo.dart';
import 'package:UpDown/features/elevators/data/models/elevator_summary_response_model.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevators_cubit/elevators_cubit.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevators_section/sliver_grid_section.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:UpDown/core/theme/app_skeleton.dart';

class ElevatorsSliverGridSectionBuilder extends StatelessWidget {
  const ElevatorsSliverGridSectionBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElevatorsCubit, ElevatorsState>(
      builder: (context, state) {
        if (state.status == ContentStatus.error) {
          return SliverToBoxAdapter(
              child: ScreenEcho(
            message: state.errorMsg!,
          ));
        }
        return SliverPadding(
          padding: AppInsets.h8,
          sliver: AppSkeletonizer(
            isSliver: true,
            enabled: state.status == ContentStatus.loading,
            child: ElevatorsSliverGridSection(
              elevators: state.status == ContentStatus.loaded
                  ? state.elevators!
                  : List.generate(
                      2, (_) => ElevatorSummaryResponseModel.empty()),
            ),
          ),
        );
      },
    );
  }
}
