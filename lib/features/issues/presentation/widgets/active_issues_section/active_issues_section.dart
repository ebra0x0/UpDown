import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:UpDown/features/issues/presentation/widgets/active_issues_section/active_issues_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActiveIssuesSection extends StatelessWidget {
  const ActiveIssuesSection({super.key, required this.state});

  final IssuesLoaded state;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "الأعطال الحالية",
        style: Styles.textStyle16,
      ),
      SizedBox(height: 8.h),
      Expanded(
        child: ActiveIssuesListView(
          state: state,
        ),
      ),
    ]);
  }
}
