import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/custom_sliver_app_bar.dart';
import 'package:UpDown/core/widgets/header_section.dart';
import 'package:UpDown/features/issues/presentation/widgets/active_issues_section/active_issues_section_builder.dart';
import 'package:flutter/widgets.dart';
import 'package:UpDown/features/buildings/presentation/widgets/buildings_section/sliver_grid_section_builder.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      CustomSliverAppBar(
        title: "أنت تدير",
        isCenterTitle: false,
      ),
      SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          sliver: BuildingsSliverGridSectionBuilder()),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        sliver: SliverToBoxAdapter(
            child: HeaderSection(
          title: "الأعطال الحالية",
          titleStyle: Styles.textStyle18,
          actionText: "عرض الكل",
          onActionTap: () {},
        )),
      ),
      SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          sliver: ActiveIssuesSectionBuilder()),
    ]);
  }
}
