import 'package:flutter/material.dart';
import 'previous_reports_item.dart';

class PreviousReportsListView extends StatelessWidget {
  const PreviousReportsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return PreviousReportItem();
        });
  }
}
