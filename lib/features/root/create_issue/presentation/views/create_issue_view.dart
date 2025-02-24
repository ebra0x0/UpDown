import 'package:UpDown/features/root/create_issue/presentation/views/widgets/create_issue_body.dart';
import 'package:flutter/material.dart';

class CreateIssueView extends StatelessWidget {
  const CreateIssueView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الإبلاغ عن عطل جديد'),
      ),
      body: CreateReportBody(),
    );
  }
}
