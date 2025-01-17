import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/features/home/presentation/views/widgets/active_report/active_reports_grid.dart';
import 'package:flutter/material.dart';
import '../../../../../core/widgets/header_text.dart';
import 'previous_reports/previous_reports_list_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: HeaderText(
                  title: "العطل الحالي", textStyle: Styles.textStyle16)),
          SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverFillRemaining(child: ActiveReportsGrid()),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 16,
            ),
          ),
          SliverToBoxAdapter(
            child: HeaderText(
              title: "الأعطال السابقة",
              textStyle: Styles.textStyle16,
            ),
          ),
          SliverFillRemaining(child: PreviousReportsListView()),
        ],
      ),
    );
  }
}
