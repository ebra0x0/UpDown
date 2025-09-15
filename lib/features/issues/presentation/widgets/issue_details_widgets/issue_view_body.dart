import 'dart:developer';

import 'package:UpDown/core/theme/app_skeleton.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/extensions/date_time_ext.dart';
import 'package:UpDown/features/issues/presentation/manager/issue_details_cubit/issue_details_cubit.dart';
import 'package:UpDown/features/issues/presentation/widgets/issue_details_widgets/issue_description_section.dart';
import 'package:UpDown/features/issues/presentation/widgets/issue_details_widgets/issue_info_section.dart';
import 'package:UpDown/features/issues/presentation/widgets/issue_details_widgets/issue_media_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'issue_elevator_info_section.dart';

class IssueViewBody extends StatelessWidget {
  const IssueViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssueDetailsCubit, IssueDetailsState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        log(state.issue?.mediaList.length.toString() ?? '0');
        return SliverList(
            delegate: SliverChildListDelegate.fixed(<Widget>[
          const SizedBox(height: 16),
          AppSkeletonizer(
            enabled: state.status == ContentStatus.loading,
            child: IssueInfoSection(
              issueId: state.issue!.id,
              issueType: state.issue!.issueType,
              issueStatus: state.issue!.status,
              issueDate: state.issue!.createdAt.toDateTimeFormat(),
            ),
          ),
          SizedBox(height: 16.sp),
          AppSkeletonizer(
            enabled: state.status == ContentStatus.loading,
            child: IssueElevatorInfoSection(
              elevatorName: state.issue!.elevatorName,
              buildingName: state.issue!.buildingName,
            ),
          ),
          SizedBox(height: 16.sp),
          Visibility(
            visible: state.issue!.description != null,
            child: AppSkeletonizer(
              enabled: state.status == ContentStatus.loading,
              child: IssueDescriptionSection(
                  issuerDescription: state.issue!.description!),
            ),
          ),
          const SizedBox(height: 16),
          if (state.issue!.mediaList.isNotEmpty)
            IssueMediaBox(mediaUrl: state.issue!.mediaList.first.url),
        ]));
      },
    );
  }
}
