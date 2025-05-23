import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/material.dart';

class ElevatorBoxBody extends StatelessWidget {
  const ElevatorBoxBody(
      {super.key, required this.status, required this.issueType});

  final ElevatorStatus status;
  final IssueType? issueType;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(status.description(context, issueType),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Styles.textStyle14
                .copyWith(fontWeight: FontWeight.bold, color: AppTheme.grey)),
      ),
    );
  }
}
