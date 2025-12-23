import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/theme/app_radius.dart';
import 'package:UpDown/core/theme/app_spacing.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/theme/app_theme.dart';

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
    this.isThreeLine = false,
    this.footer,
    this.padding,
    this.backgroundColor,
    this.titleStyle,
    this.subtitleStyle,
  });

  final String title;
  final String? subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final Widget? leading;
  final Widget? trailing;
  final Widget? footer;
  final VoidCallback? onTap;
  final bool isLoading;
  final Color? loadingColor;
  final bool isThreeLine;
  final EdgeInsets? padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 50.sp,
      isThreeLine: isThreeLine,
      contentPadding: padding ??
          AppInsets.h16.copyWith(top: AppSpacing.s2, bottom: AppSpacing.s2),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.borderRadius8),
      enabled: !isLoading,
      tileColor: backgroundColor ?? AppTheme.backgroundColor,
      onTap: isLoading ? null : onTap,
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: titleStyle ??
            AppTextStyles.textStyle14.copyWith(color: AppTheme.textColor),
      ),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle!,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: subtitleStyle ??
                  AppTextStyles.textStyle12.copyWith(
                    color: AppTheme.greyColor,
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
