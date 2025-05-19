import 'package:UpDown/features/issues/presentation/widgets/active_issues_section/active_issues_section_builder.dart';
import 'package:flutter/material.dart';
import 'package:UpDown/features/buildings/presentation/widgets/buildings_section/buildings_grid_section_builder.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: CustomScrollView(slivers: [
        BuildingsGridSectionBuilder(),
        SliverToBoxAdapter(child: SizedBox(height: 24)),
        ActiveIssuesSectionBuilder(),
      ]),
    );
  }
}
