import 'package:UpDown/features/issues/data/models/issue_model.dart';
import 'package:UpDown/features/issues/presentation/widgets/issue_details_widgets/issue_view_body.dart';
import 'package:flutter/material.dart';

class IssueView extends StatelessWidget {
  final IssueModel issue;

  const IssueView({super.key, required this.issue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IssueViewBody(issue: issue),
    );
  }
}
