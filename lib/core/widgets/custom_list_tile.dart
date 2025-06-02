import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.isLoading = false,
    this.loadingColor,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isLoading;
  final Color? loadingColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.sp),
      shape: RoundedRectangleBorder(borderRadius: Styles.borderRadius8),
      enabled: isLoading,
      tileColor: AppTheme.background,
      onTap: isLoading ? null : onTap,
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: Styles.textStyle14.copyWith(color: AppTheme.white),
      ),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle!,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Styles.textStyle12.copyWith(
                color: AppTheme.grey,
              ),
            ),
      leading: isLoading
          ? SizedBox(
              width: 16.sp,
              height: 16.sp,
              child: LoadingIndicator(
                color: loadingColor,
              ),
            )
          : leading,
      trailing: trailing,
    );
  }
}
