import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/widgets/custom_sliver_app_bar.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevators_cubit/elevators_cubit.dart';
import 'package:UpDown/features/elevators/presentation/widgets/active_issue/active_issue_builder.dart';
import 'package:UpDown/features/elevators/presentation/widgets/units_section/units_section_builder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ElevatorDetailsViewBody extends StatelessWidget {
  const ElevatorDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _SliverAppBarBuilder(),
        SliverActiveIssueBuilder(),
        SliverToBoxAdapter(child: SizedBox(height: 24.sp)),
        SliverUnitsSectionBuilder(),
      ],
    );
  }
}

class _SliverAppBarBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElevatorsCubit, ElevatorsState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return CustomSliverAppBar(
          title: state.currentElevator?.name ?? "اسم المصعد",
          isLoading: state.status == ContentStatus.loading,
        );
      },
    );
  }
}
