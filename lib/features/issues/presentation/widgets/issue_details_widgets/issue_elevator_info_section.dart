import 'package:UpDown/core/theme/app_icons.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/widgets/bubble_icon.dart';
import 'package:UpDown/core/widgets/custom_list_tile.dart';
import 'package:UpDown/core/widgets/section_box.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IssueElevatorInfoSection extends StatelessWidget {
  const IssueElevatorInfoSection(
      {super.key, required this.elevatorName, required this.buildingName});
  final String elevatorName;
  final String buildingName;

  @override
  Widget build(BuildContext context) {
    return SectionBox(
      children: [
        Text("تفاصيل المصعد", style: AppTextStyles.textStyle16),
        SizedBox(height: 18.sp),
        CustomListTile(
            padding: EdgeInsets.zero,
            leading: BubbleIcon(
              icon: AppIcons.elevatorIcon,
            ),
            title: "المصعد",
            subtitle: elevatorName,
            titleStyle:
                AppTextStyles.textStyle12.copyWith(color: AppTheme.grey),
            subtitleStyle: AppTextStyles.textStyle14),
        CustomListTile(
            padding: EdgeInsets.zero,
            leading: BubbleIcon(icon: AppIcons.apartmentIcon),
            title: "المبنى",
            subtitle: buildingName,
            titleStyle:
                AppTextStyles.textStyle12.copyWith(color: AppTheme.grey),
            subtitleStyle: AppTextStyles.textStyle14),
      ],
    );
  }
}
