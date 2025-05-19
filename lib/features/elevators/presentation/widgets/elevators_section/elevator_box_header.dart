import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/extensions/ext_icon.dart';
import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/bubble_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ElevatorBoxHeader extends StatelessWidget {
  const ElevatorBoxHeader(
      {super.key, required this.name, required this.status});
  final String name;
  final ElevatorStatus status;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name,
            style: Styles.textStyle14.copyWith(color: Pallete.lightSecondary)),
        status.name != "disabled"
            ? BubbleStatus(color: status.color)
            : Styles.lockIcon.copyWith(color: status.color, size: 16.w),
      ],
    );
  }
}
