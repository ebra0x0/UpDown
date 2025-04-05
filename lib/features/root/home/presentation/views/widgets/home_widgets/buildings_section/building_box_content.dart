import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/custom_card.dart';
import 'package:UpDown/features/root/home/data/model/building_summary_model.dart';
import 'package:flutter/material.dart';

class BuildingBoxContent extends StatelessWidget {
  const BuildingBoxContent({
    super.key,
    required this.building,
  });

  final BuildingSummaryModel building;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        BuildingBoxHeader(
            buildingName: building.name,
            elevatorsCount: building.elevatorsCount),
        BuildingBoxFooter(
          hasActiveReport: building.hasActiveReport,
        )
      ]),
    );
  }
}

class BuildingBoxHeader extends StatelessWidget {
  const BuildingBoxHeader({
    super.key,
    required this.buildingName,
    required this.elevatorsCount,
  });
  final String buildingName;
  final int elevatorsCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                style: Styles.textStyle14.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
        Icon(
          Icons.apartment_rounded,
          size: 24,
          color: Colors.grey,
        ),
      ],
    );
  }
}

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
        Text(
          hasActiveReport ? "يوجد عطل" : "لا توجد أعطال",
          style: Styles.textStyle14
              .copyWith(color: hasActiveReport ? Colors.red : Colors.grey),
        ),
        Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.grey,
        ),
      ],
    );
  }
}
