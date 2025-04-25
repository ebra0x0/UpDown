import 'package:flutter/material.dart';
import 'create_issue_form.dart';

class CreateIssueBody extends StatelessWidget {
  const CreateIssueBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CreateIssueForm());
  }
}
