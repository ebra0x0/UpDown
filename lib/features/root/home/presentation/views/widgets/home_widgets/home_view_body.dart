import 'package:UpDown/core/utils/service_locator.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/features/root/home/data/repos/home_repo/home_repo_imp.dart';
import 'package:UpDown/features/root/home/presentation/manager/active_issues_cubit/cubit/active_issues_cubit.dart';
import 'package:UpDown/features/root/home/presentation/manager/buildings_summary_cubit/cubit/buildings_summary_cubit.dart';
import 'package:UpDown/features/root/home/presentation/views/widgets/home_widgets/active_issues_section/active_issues_section.dart';
import 'package:UpDown/features/root/home/presentation/views/widgets/home_widgets/buildings_section/buildings_grid_view_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BuildingsSummaryCubit(gitIt.get<HomeRepoImp>())
            ..fetchBuildingsSummary(context),
        ),
        BlocProvider(
          create: (context) =>
              ActiveIssuesCubit(gitIt.get<HomeRepoImp>())..fetchActiveIssues(),
        ),
      ],
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: CustomScrollView(slivers: [
          BuildingsGridViewSection(),
          SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "الأعطال الحالية",
                  style: Styles.textStyle18,
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
          ActiveIssuesSection(),
        ]),
      ),
    );
  }
}
