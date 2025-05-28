import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/extensions/ext_icon.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/material.dart';

class BuildingBoxHeader extends StatelessWidget {
  const BuildingBoxHeader({
    super.key,
    required this.buildingName,
    required this.elevatorsCount,
    required this.hasActiveReport,
  });
  final String buildingName;
  final int elevatorsCount;
  final bool hasActiveReport;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                buildingName,
                style: Styles.textStyle18,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "$elevatorsCount مصعد",
                style: Styles.textStyle14.copyWith(color: AppTheme.grey),
              ),
            ],
          ),
        ),
        Styles.apartmentIcon.copyWith(
          color: hasActiveReport ? AppTheme.red : null,
        )
      ],
    );
  }
}
