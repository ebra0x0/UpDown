import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/material.dart';

class StatusTitle extends StatelessWidget {
  const StatusTitle({
    super.key,
    required this.status,
  });

  final ElevatorStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: Styles.borderRadius8,
        color: status.color.withValues(alpha: 0.2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        status.title(context),
        style: Styles.textStyle16.copyWith(color: status.color),
      ),
    );
  }
}
