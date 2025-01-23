import 'package:UpDown/core/utils/model/building_model.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class BuildingBoxContent extends StatelessWidget {
  const BuildingBoxContent({
    super.key,
    required this.building,
  });

  final BuildingModel building;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BuildingBoxHeader(building: building),
            BuildingBoxFooter()
          ]),
    );
  }
}

class BuildingBoxHeader extends StatelessWidget {
  const BuildingBoxHeader({
    super.key,
    required this.building,
  });

  final BuildingModel building;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              building.name,
              style: Styles.textStyle18,
            ),
            Text(
              "${building.elevators.length} مصعد",
              style: Styles.textStyle14.copyWith(color: Colors.grey),
            ),
          ],
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
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "",
          style: Styles.textStyle14.copyWith(color: Colors.green),
        ),
        Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.grey,
        ),
      ],
    );
  }
}
