import 'package:UpDown/core/theme/app_radius.dart';
import 'package:UpDown/core/theme/app_theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBorders {
  static final Border generalBoxBorder = Border.all(
    color: AppTheme.grey.withValues(
      alpha: 0.2,
    ),
    width: 1.3.w,
  );

  static final Border errorBoxBorder = Border.all(
    color: AppTheme.red.withValues(
      alpha: 0.2,
    ),
    width: 1.3.w,
  );

  // Outlined Border

  static final OutlineInputBorder generalBorder = OutlineInputBorder(
    borderRadius: AppRadius.borderRadius8,
    borderSide:
        BorderSide(color: AppTheme.grey.withValues(alpha: .2), width: 1.3.w),
  );

  static final OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: AppRadius.borderRadius8,
    borderSide: BorderSide(color: AppTheme.red, width: 1.3.w),
  );

  static final OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: AppRadius.borderRadius8,
    borderSide: BorderSide(color: AppTheme.primary, width: 1.3.w),
  );

  static final OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderRadius: AppRadius.borderRadius8,
    borderSide:
        BorderSide(color: AppTheme.grey.withValues(alpha: .2), width: 1.3.w),
  );
}
