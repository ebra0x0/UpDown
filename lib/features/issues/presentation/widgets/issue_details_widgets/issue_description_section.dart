import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/widgets/section_box.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IssueDescriptionSection extends StatelessWidget {
  final String issuerDescription;

  const IssueDescriptionSection({
    super.key,
    required this.issuerDescription,
  });

  @override
  Widget build(BuildContext context) {
    return SectionBox(
      children: [
        Text('وصف العطل', style: AppTextStyles.textStyle16),
        SizedBox(height: 12.sp),
        SectionBox(color: AppTheme.surface, children: [
          Text(
            issuerDescription,
            style: AppTextStyles.textStyle14,
          )
        ]),
      ],
    );
  }
}
