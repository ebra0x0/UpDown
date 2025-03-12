import 'package:UpDown/core/utils/status_handler.dart';
import 'package:flutter/material.dart';

class BubbleStatus extends StatelessWidget {
  const BubbleStatus({super.key, required this.status, this.issueType = ""});

  final String status;
  final String issueType;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: StatusHandler.fromIssueStatus(
                  status: status, issueType: issueType)
              .color
              .withValues(alpha: 0.2),
        ),
        child: Icon(
          Icons.circle,
          color: StatusHandler.fromIssueStatus(
                  status: status, issueType: issueType)
              .color,
          size: 12,
        ));
  }
}
