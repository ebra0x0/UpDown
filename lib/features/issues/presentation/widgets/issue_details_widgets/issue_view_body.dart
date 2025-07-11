import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/extensions/ex_date_time.dart';
import 'package:UpDown/features/issues/presentation/manager/issue_details_cubit/issue_details_cubit.dart';
import 'package:UpDown/features/issues/presentation/widgets/issue_details_widgets/issue_description_section.dart';
import 'package:UpDown/features/issues/presentation/widgets/issue_details_widgets/issue_info_section.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'issue_elevator_info_section.dart';

class IssueViewBody extends StatelessWidget {
  const IssueViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssueDetailsCubit, IssueDetailsState>(
      builder: (context, state) {
        return SliverList(
            delegate: SliverChildListDelegate.fixed(<Widget>[
          Skeletonizer(
            enabled: state.status == ContentStatus.loading,
            child: IssueInfoSection(
              issueId: state.issue!.id,
              issueType: state.issue!.issueType,
              issueStatus: state.issue!.status,
              issueDate: state.issue!.createdAt.toDateTimeFormat(),
            ),
          ),
          SizedBox(height: 16.sp),
          Skeletonizer(
            enabled: state.status == ContentStatus.loading,
            child: IssueElevatorInfoSection(
              elevatorName: state.issue!.elevatorName,
              buildingName: state.issue!.buildingName,
            ),
          ),
          SizedBox(height: 16.sp),
          Visibility(
            visible: state.issue!.description != null,
            child: Skeletonizer(
              enabled: state.status == ContentStatus.loading,
              child: IssueDescriptionSection(
                  issuerDescription: state.issue!.description!),
            ),
          ),
        ]));
      },
    );
  }
}
