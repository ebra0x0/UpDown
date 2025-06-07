import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/back_nav_button.dart';
import 'package:UpDown/features/issues/data/models/issue_model.dart';
import 'package:UpDown/features/issues/presentation/widgets/issue_details_widgets/issue_info_section.dart';
import 'package:flutter/material.dart';

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
      SliverToBoxAdapter(child: IssueInfoSection(issue: issue)),
    ]);
  }
}
