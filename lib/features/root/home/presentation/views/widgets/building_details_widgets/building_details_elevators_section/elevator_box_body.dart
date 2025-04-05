import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/material.dart';

class ElevatorBoxBody extends StatelessWidget {
  const ElevatorBoxBody({super.key, required this.status});

  final ElevatorStatus status;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(status.description(context),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Styles.textStyle14.copyWith(
                fontWeight: FontWeight.bold, color: Pallete.lightSecondary)),
      ),
    );
  }
}
