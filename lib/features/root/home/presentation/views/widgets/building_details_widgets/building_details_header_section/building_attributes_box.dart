import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/material.dart';

class BuildingAttributesBox extends StatelessWidget {
  const BuildingAttributesBox({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: Column(spacing: 6, children: [
        Icon(
          icon,
          color: Pallete.textSecondary,
        ),
        Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Styles.textStyle14,
        ),
      ]),
    );
  }
}
