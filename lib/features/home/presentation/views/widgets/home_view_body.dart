import 'package:flutter/material.dart';
import '../../../../../core/widgets/header_text.dart';
import 'active_report.dart';
import 'previous_issues_listView.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView(
        children: [
          HeaderText(title: "العطل الحالي"),
          ActiveReport(), // Active report
          SizedBox(
            height: 16,
          ),
          HeaderText(title: "الأعطال السابقة"),
          PreviousIssuesListView(),
        ],
      ),
    );
  }
}
