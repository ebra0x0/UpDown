import 'package:UpDown/core/theme/app_skeleton.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/extensions/date_time_ext.dart';
import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:UpDown/features/issues/presentation/widgets/issue_details_widgets/issue_description_section.dart';
import 'package:UpDown/features/issues/presentation/widgets/issue_details_widgets/issue_info_section.dart';
import 'package:UpDown/features/issues/presentation/widgets/issue_details_widgets/issue_media_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'issue_elevator_info_section.dart';

class IssueViewBuilder extends StatelessWidget {
  const IssueViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssuesCubit, IssuesState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return SliverList(
            delegate: SliverChildListDelegate.fixed(<Widget>[
          const SizedBox(height: 16),
          AppSkeletonizer(
            enabled: state.status == ContentStatus.loading,
            child: IssueInfoSection(
              issueId: state.currentIssue!.id,
              issueType: state.currentIssue!.issueType,
              issueStatus: state.currentIssue!.status,
              issueDate: state.currentIssue!.createdAt.toDateTimeFormat(),
            ),
          ),
          SizedBox(height: 16.sp),
          AppSkeletonizer(
            enabled: state.status == ContentStatus.loading,
            child: IssueElevatorInfoSection(
              elevatorName: state.currentIssue!.elevatorName,
              buildingName: state.currentIssue!.buildingName,
            ),
          ),
          SizedBox(height: 16.sp),
          Visibility(
            visible: state.currentIssue!.description != null,
            child: AppSkeletonizer(
              enabled: state.status == ContentStatus.loading,
              child: IssueDescriptionSection(
                  issuerDescription: state.currentIssue!.description!),
            ),
          ),
          const SizedBox(height: 16),
          if (state.currentIssue!.mediaList.isNotEmpty)
            IssueMediaBox(mediaUrl: state.currentIssue!.mediaList.first.url),
        ]));
      },
    );
  }
}
