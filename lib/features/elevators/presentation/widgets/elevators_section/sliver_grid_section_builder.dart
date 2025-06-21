import 'package:UpDown/core/widgets/screen_echo.dart';
import 'package:UpDown/features/elevators/data/models/elevator_summary_model.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevators_cubit/elevators_cubit.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevators_section/sliver_grid_section.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ElevatorsSliverGridSectionBuilder extends StatelessWidget {
  const ElevatorsSliverGridSectionBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElevatorsCubit, ElevatorsState>(
      builder: (context, state) {
        if (state.status == ElevatorsStates.error) {
          return SliverToBoxAdapter(
              child: ScreenEcho(
            message: state.errorMsg!,
          ));
        }
        return SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 8.sp),
          sliver: Skeletonizer.sliver(
            enabled: state.status == ElevatorsStates.loading,
            child: ElevatorsSliverGridSection(
              elevators: state.status == ElevatorsStates.loaded
                  ? state.elevators!
                  : List.generate(2, (_) => ElevatorSummaryModel.empty()),
            ),
          ),
        );
      },
    );
  }
}
