import 'package:flutter/material.dart';

import 'active_report.dart';
import 'reports_grid_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          ActiveReport(), // Active report
          SizedBox(
            height: 10,
          ),
          ReportsGridView(), // Reports Boxes
        ],
      ),
    );
  }
}
