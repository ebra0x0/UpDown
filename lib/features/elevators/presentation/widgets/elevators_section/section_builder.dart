import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/widgets/header_section.dart';
import 'package:UpDown/core/widgets/screen_echo.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevators_cubit/elevators_cubit.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevators_section/section.dart';
import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:UpDown/core/theme/app_skeleton.dart';

class ElevatorsSectionBuilder extends StatelessWidget {
  const ElevatorsSectionBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElevatorsCubit, ElevatorsState>(
      builder: (context, state) {
        if (state.status == ContentStatus.error) {
          return SliverToBoxAdapter(
              child: ScreenEcho(message: state.errorMsg!));
        }

        return SliverPadding(
          padding: AppInsets.h8,
          sliver: AppSkeletonizer(
            isSliver: true,
            enabled: state.status == ContentStatus.loading,
            child: SliverList(
              delegate: SliverChildListDelegate([
                Visibility(
                  visible: state.buildingElevators?.isNotEmpty ?? false,
                  child: HeaderSection(
                    title: "المصاعد",
                    titleStyle: AppTextStyles.textStyle18,
                  ),
                ),
                BlocBuilder<IssuesCubit, IssuesState>(
                  buildWhen: (previous, current) => previous != current,
                  builder: (context, issueState) {
                    return ElevatorsSection(
                      elevators: state.buildingElevators ?? [],
                      issues: issueState.issues ?? [],
                    );
                  },
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
