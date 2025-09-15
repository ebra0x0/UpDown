import 'package:UpDown/features/issues/presentation/widgets/issue_details_widgets/issue_view_builder.dart';
import 'package:flutter/material.dart';

class IssueView extends StatelessWidget {
  const IssueView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IssueViewBuilder(),
    );
  }
}
