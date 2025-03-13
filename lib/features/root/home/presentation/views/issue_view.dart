import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/status_handler.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/features/root/create_issue/data/model/issue_model.dart';
import 'package:flutter/material.dart';

class IssueView extends StatelessWidget {
  final IssueModel issue;

  const IssueView({super.key, required this.issue});

  @override
  Widget build(BuildContext context) {
    final StatusHandler status = StatusHandler.fromIssueStatus(
        status: issue.status!, issueType: issue.issueType);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("عطل"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.apartment_rounded,
                      color: Pallete.secondary, size: 24),
                  SizedBox(width: 8),
                  Text(
                    issue.buildingName,
                    style: Styles.textStyle14.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.door_sliding_outlined,
                      color: Pallete.secondary, size: 24),
                  SizedBox(width: 8),
                  Text(
                    issue.elevatorNumber,
                    style: Styles.textStyle14,
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.info, color: Pallete.secondary, size: 24),
                  SizedBox(width: 8),
                  Text(
                    status.title,
                    style: Styles.textStyle14,
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.description, color: Pallete.secondary, size: 24),
                  SizedBox(width: 8),
                  Text(
                    issue.description,
                    style: Styles.textStyle14,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
