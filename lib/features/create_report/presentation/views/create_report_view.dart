import 'package:UpDown/features/create_report/presentation/views/widgets/create_report_body.dart';
import 'package:flutter/material.dart';

class CreateReportView extends StatelessWidget {
  const CreateReportView({super.key});

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
