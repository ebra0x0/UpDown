import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/material.dart';

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
                style:
                    Styles.textStyle14.copyWith(color: Pallete.lightSecondary),
              ),
            ],
          ),
        ),
        Icon(
          Icons.apartment_rounded,
          size: 24,
          color: Pallete.lightSecondary,
        ),
      ],
    );
  }
}
