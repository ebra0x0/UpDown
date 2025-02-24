import 'package:flutter/material.dart';
import 'create_issue_form.dart';

class CreateReportBody extends StatelessWidget {
  const CreateReportBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CreateReportForm());
  }
}
