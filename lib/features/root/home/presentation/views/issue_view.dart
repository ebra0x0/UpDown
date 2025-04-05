import 'package:UpDown/features/root/create_issue/data/model/issue_model.dart';
import 'package:UpDown/features/root/home/presentation/views/widgets/issue_widgets/issue_view_body.dart';
import 'package:flutter/material.dart';

class IssueView extends StatelessWidget {
  final IssueModel issue;

  const IssueView({super.key, required this.issue});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("عطل"),
        ),
        body: IssueViewBody(issue: issue),
      ),
    );
  }
}
