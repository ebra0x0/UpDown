import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/widgets/custom_sliver_app_bar.dart';
import 'package:UpDown/features/issues/presentation/widgets/issue_details_widgets/issue_view_builder.dart';
import 'package:flutter/material.dart';

class IssueViewBody extends StatelessWidget {
  const IssueViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CustomSliverAppBar(
          title: "تفاصيل العطل",
        ),
        SliverPadding(padding: AppInsets.h8, sliver: const IssueViewBuilder()),
      ],
    );
  }
}
