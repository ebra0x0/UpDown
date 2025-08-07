import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/widgets/custom_sliver_app_bar.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevator_details_cubit/elevator_details_cubit.dart';
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
        BlocBuilder<ElevatorDetailsCubit, ElevatorDetailsState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            return CustomSliverAppBar(
              title: state.elevator?.name ?? "اسم المصعد",
              isLoading: state.status == ContentStatus.loading,
            );
          },
        ),
        SliverActiveIssueBuilder(),
        SliverToBoxAdapter(child: SizedBox(height: 24.sp)),
        SliverUnitsSectionBuilder(),
      ],
    );
  }
}
