import 'package:UpDown/features/root/home/presentation/views/widgets/home_widgets/active_issues_section/active_issues_section.dart';
import 'package:UpDown/features/root/home/presentation/views/widgets/home_widgets/buildings_section/buildings_grid_view_section.dart';
import 'package:flutter/material.dart';

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
        BuildingsGridViewSection(),
        SliverToBoxAdapter(child: SizedBox(height: 24)),
        SliverFillRemaining(child: ActiveIssuesSection()),
      ]),
    );
  }
}
