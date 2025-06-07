import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/back_nav_button.dart';
import 'package:UpDown/features/issues/data/models/issue_model.dart';
import 'package:UpDown/features/issues/presentation/widgets/issue_details_widgets/issue_info_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'issue_elevator_info_section.dart';

class IssueViewBody extends StatelessWidget {
  const IssueViewBody({
    super.key,
    required this.issue,
  });

  final IssueModel issue;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        leading: BackButtonNavigation(),
        floating: true,
        title: Text("تفاصيل العطل", style: Styles.textStyle22),
      ),
      SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 8.sp),
          sliver: SliverToBoxAdapter(
              child: IssueInfoSection(
            issueId: issue.id!,
            issueType: issue.issueType,
            issueStatus: issue.status!,
            issueDate: issue.createdAt!,
          ))),
      SliverToBoxAdapter(child: SizedBox(height: 24.sp)),
      SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 8.sp),
          sliver: SliverToBoxAdapter(
              child: IssueElevatorInfoSection(
            elevatorName: issue.elevatorName,
            buildingName: issue.buildingName,
          ))),
    ]);
  }
}
