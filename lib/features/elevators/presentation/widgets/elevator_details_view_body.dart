import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/widgets/back_nav_button.dart';
import 'package:UpDown/core/widgets/custom_sliver_app_bar.dart';
import 'package:UpDown/core/widgets/header_section.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevator_details_cubit/elevator_details_cubit.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevator_units_cubit/elevator_units_cubit.dart';
import 'package:UpDown/features/elevators/presentation/widgets/active_issue/active_issue_builder.dart';
import 'package:UpDown/features/elevators/presentation/widgets/units_section/units_section_builder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:UpDown/core/theme/app_skeleton.dart';

class ElevatorDetailsViewBody extends StatelessWidget {
  const ElevatorDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _SliverAppBarBuilder(),
        SliverActiveIssueBuilder(),
        SliverToBoxAdapter(child: SizedBox(height: 24.sp)),
        _HeaderSectionBuilder(),
        SliverUnitsSectionBuilder(),
      ],
    );
  }
}

class _HeaderSectionBuilder extends StatelessWidget {
  const _HeaderSectionBuilder();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElevatorUnitsCubit, ElevatorUnitsState>(
      builder: (context, state) {
        return AppSkeletonizer(
          isSliver: true,
          enabled: state.status == ContentStatus.loading,
          child: SliverToBoxAdapter(
            child: HeaderSection(
                title: "الوحدات", titleStyle: AppTextStyles.textStyle18),
          ),
        );
      },
    );
  }
}

class _SliverAppBarBuilder extends StatelessWidget {
  const _SliverAppBarBuilder();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElevatorDetailsCubit, ElevatorDetailsState>(
      builder: (context, state) {
        return AppSkeletonizer(
          isSliver: true,
          enabled: state.status == ContentStatus.loading,
          child: CustomSliverAppBar(
            leading: const BackButtonNavigation(),
            title: state.status == ContentStatus.loaded
                ? "المصعد ${state.elevator!.name}"
                : "اسم المصعد",
          ),
        );
      },
    );
  }
}
