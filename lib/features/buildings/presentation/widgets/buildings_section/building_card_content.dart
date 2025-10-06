import 'package:UpDown/core/theme/app_icons.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/extensions/icon_ext.dart';
import 'package:UpDown/core/widgets/custom_card.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:flutter/widgets.dart';

class BuildingCardContent extends StatelessWidget {
  const BuildingCardContent({
    super.key,
    required this.building,
  });

  final BuildingModel building;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        _BuildingCardHeader(
            hasActiveReport: building.reportsCount > 0,
            buildingName: building.name,
            elevatorsCount: building.elevatorsCount),
        _BuildingCardFooter(
          hasActiveReport: building.reportsCount > 0,
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
                style: AppTextStyles.textStyle18,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "$elevatorsCount مصعد",
                style: AppTextStyles.textStyle14.copyWith(color: AppTheme.grey),
              ),
            ],
          ),
        ),
        AppIcons.apartmentIcon.copyWith(
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
            style: AppTextStyles.textStyle14.copyWith(color: AppTheme.red),
          ),
        ),
        AppIcons.forwardIcon.copyWith(
          color: hasActiveReport ? AppTheme.red : null,
        )
      ],
    );
  }
}
