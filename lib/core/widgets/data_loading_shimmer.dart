import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContentLoadingShimmer extends StatelessWidget {
  const ContentLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          minHeight: 100.sp,
        ),
        decoration: BoxDecoration(
          borderRadius: Styles.borderRadius8,
          color: AppTheme.primary.withValues(alpha: 0.2),
        ),
      ),
    );
  }
}
