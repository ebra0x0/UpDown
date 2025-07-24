import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/widgets/custom_sliver_app_bar.dart';
import 'package:UpDown/features/issues/presentation/widgets/issues_section/issues_section_builder.dart';
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
      const SliverToBoxAdapter(child: SizedBox(height: 8)),
      SliverPadding(
        padding: AppInsets.h8,
        sliver: BuildingsSliverGridSectionBuilder(),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 8)),
      SliverPadding(padding: AppInsets.h8, sliver: IssuesSectionBuilder()),
    ]);
  }
}
