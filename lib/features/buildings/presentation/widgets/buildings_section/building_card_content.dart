import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/extensions/ext_icon.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/custom_card.dart';
import 'package:UpDown/features/buildings/data/models/building_summary_model.dart';
import 'package:flutter/material.dart';

class BuildingCardContent extends StatelessWidget {
  const BuildingCardContent({
    super.key,
    required this.building,
  });

  final BuildingSummaryModel building;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        _BuildingCardHeader(
            hasActiveReport: building.hasActiveReport,
            buildingName: building.name,
            elevatorsCount: building.elevatorsCount),
        _BuildingCardFooter(
          hasActiveReport: building.hasActiveReport,
        )
      ]),
    );
  }
}

class _BuildingCardHeader extends StatelessWidget {
  const _BuildingCardHeader({
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

class _BuildingCardFooter extends StatelessWidget {
  const _BuildingCardFooter({
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
