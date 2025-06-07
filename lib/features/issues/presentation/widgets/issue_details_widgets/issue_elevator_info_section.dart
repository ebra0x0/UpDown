import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/bubble_icon.dart';
import 'package:UpDown/core/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IssueElevatorInfoSection extends StatelessWidget {
  const IssueElevatorInfoSection(
      {super.key, required this.elevatorName, required this.buildingName});
  final String elevatorName;
  final String buildingName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 22.sp),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: Styles.borderRadius14,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("تفاصيل المصعد", style: Styles.textStyle16),
          SizedBox(height: 22.sp),
          CustomListTile(
              padding: EdgeInsets.zero,
              leading: BubbleIcon(
                icon: Styles.elevatorIcon,
              ),
              title: "اسم المصعد",
              subtitle: elevatorName,
              titleStyle: Styles.textStyle12.copyWith(color: AppTheme.grey),
              subtitleStyle: Styles.textStyle14),
          SizedBox(height: 12.sp),
          CustomListTile(
              padding: EdgeInsets.zero,
              leading: BubbleIcon(icon: Styles.apartmentIcon),
              title: "المبنى",
              subtitle: buildingName,
              titleStyle: Styles.textStyle12.copyWith(color: AppTheme.grey),
              subtitleStyle: Styles.textStyle14),
        ],
      ),
    );
  }
}
