import 'package:UpDown/core/utils/extensions/ex_date_time.dart';
import 'package:UpDown/core/widgets/back_nav_button.dart';
import 'package:UpDown/core/widgets/custom_sliver_app_bar.dart';
import 'package:UpDown/features/issues/data/models/issue_model.dart';
import 'package:UpDown/features/issues/presentation/widgets/issue_details_widgets/issue_description_section.dart';
import 'package:UpDown/features/issues/presentation/widgets/issue_details_widgets/issue_info_section.dart';
import 'package:flutter/widgets.dart';
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
      CustomSliverAppBar(
        title: "تفاصيل العطل",
        leading: const BackButtonNavigation(),
      ),
      SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 8.sp),
          sliver: SliverToBoxAdapter(
              child: IssueInfoSection(
            issueId: issue.id,
            issueType: issue.issueType,
            issueStatus: issue.status,
            issueDate: issue.createdAt.toDateTimeFormat(),
          ))),
      SliverToBoxAdapter(child: SizedBox(height: 16.sp)),
      SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 8.sp),
          sliver: SliverToBoxAdapter(
              child: IssueElevatorInfoSection(
            elevatorName: issue.elevatorName,
            buildingName: issue.buildingName,
          ))),
      SliverToBoxAdapter(child: SizedBox(height: 16.sp)),
      SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 8.sp),
          sliver: SliverToBoxAdapter(
              child: IssueDescriptionSection(
                  issuerDescription: issue.description ?? ""))),
    ]);
  }
}
