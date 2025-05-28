import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/extensions/ext_icon.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/material.dart';

class BuildingBoxFooter extends StatelessWidget {
  const BuildingBoxFooter({
    super.key,
    required this.hasActiveReport,
  });

  final bool hasActiveReport;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          visible: hasActiveReport,
          child: Text(
            "يوجد عطل",
            style: Styles.textStyle14.copyWith(color: AppTheme.red),
          ),
        ),
        Styles.forwardIcon.copyWith(
          color: hasActiveReport ? AppTheme.red : null,
        )
      ],
    );
  }
}
