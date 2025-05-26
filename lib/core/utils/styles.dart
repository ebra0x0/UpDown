import 'package:UpDown/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class Styles {
  static final TextStyle textStyle12 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle textStyle14 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle textStyle16 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle textStyle18 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle textStyle20 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle textStyle26 = TextStyle(
    fontSize: 26.sp,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle textStyle30 = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.2,
  );

  // Icons

  static Icon checkIcon = Icon(
    Icons.check_circle_outline_rounded,
    color: AppTheme.green,
  );

  static Icon errorIcon = Icon(
    Icons.error_outline_rounded,
    color: AppTheme.red,
  );

  static const Icon backIcon = Icon(
    Icons.arrow_back_ios_new_rounded,
    size: 22,
  );

  static const Icon forwardIcon = Icon(
    Icons.arrow_forward_ios_rounded,
    size: 22,
  );

  static const Icon circleIcon = Icon(
    Icons.circle,
    size: 12,
  );

  static Icon addPhotoIcon = Icon(
    Icons.add_photo_alternate_outlined,
    color: AppTheme.grey,
    size: 46,
  );

  static Icon hideIcon = Icon(
    Icons.visibility_off_outlined,
    color: AppTheme.grey,
  );

  static Icon showIcon = Icon(
    Icons.visibility_outlined,
    color: AppTheme.grey,
  );

  static Icon reportIcon = Icon(
    Icons.assignment_late_outlined,
    color: AppTheme.primary,
  );

  static Icon stairsIcon = Icon(
    Icons.stairs_outlined,
    color: AppTheme.grey,
  );

  static Icon elevatorIcon = Icon(
    Icons.elevator_outlined,
    color: AppTheme.primary,
  );

  static Icon apartmentIcon = Icon(
    Icons.apartment_rounded,
    color: AppTheme.primary,
    size: 24,
  );

  static Icon timerIcon = Icon(
    Icons.timer_outlined,
    color: AppTheme.grey,
  );

  static Icon maintenanceIcon = Icon(
    Icons.build_circle_outlined,
    color: AppTheme.grey,
  );

  static Icon calendarIcon = Icon(
    Icons.calendar_month_outlined,
    color: AppTheme.grey,
  );

  static Icon descriptionIcon = Icon(
    Icons.description_outlined,
    color: AppTheme.primary,
  );

  static Icon groupIcon = Icon(
    Icons.groups_outlined,
    color: AppTheme.grey,
  );

  static Icon lockIcon = Icon(
    Icons.lock,
    color: AppTheme.grey,
  );

  static Icon homeIcon = Icon(
    Icons.roofing_rounded,
  );

  static const Icon addIcon = Icon(
    // Icons.add_circle_outline_rounded,
    Icons.add,
  );

  static const Icon userIcon = Icon(
    Icons.person_outline_rounded,
  );

  static Icon emailIcon = Icon(
    Icons.email_outlined,
    color: AppTheme.primary,
  );

  static Icon phoneIcon = Icon(
    Icons.phone_enabled_outlined,
    color: AppTheme.primary,
  );

  static Icon locationIcon = Icon(
    Icons.location_on_outlined,
    color: AppTheme.primary,
  );

  // Border Radius

  static final BorderRadius borderRadius4 =
      BorderRadius.all(Radius.circular(4.r));

  static final BorderRadius borderRadius6 =
      BorderRadius.all(Radius.circular(6.r));

  static final BorderRadius borderRadius8 =
      BorderRadius.all(Radius.circular(8.r));

  static final BorderRadius borderRadius12 =
      BorderRadius.all(Radius.circular(12.r));

  static final BorderRadius borderRadius14 =
      BorderRadius.all(Radius.circular(14.r));

  static final BorderRadius borderRadius18 =
      BorderRadius.all(Radius.circular(18.r));

  // Box Shadow

  static const BoxShadow boxShadow = BoxShadow(
    color: Color(0xFFE0E0E0),
    blurRadius: 5,
    offset: Offset(0, 4),
  );

  // Border
  static final BoxBorder generalBoxBorder = Border.all(
    color: AppTheme.grey.withValues(
      alpha: 0.2,
    ),
    width: 1.8.w,
  );

  static final BoxBorder errorBoxBorder = Border.all(
    color: AppTheme.red.withValues(
      alpha: 0.2,
    ),
    width: 1.8.w,
  );

  static final OutlineInputBorder generalBorder = OutlineInputBorder(
    borderRadius: Styles.borderRadius8,
    borderSide:
        BorderSide(color: AppTheme.grey.withValues(alpha: .2), width: 1.8.w),
  );

  static final OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: Styles.borderRadius8,
    borderSide: BorderSide(color: AppTheme.red, width: 1.8.w),
  );

  static final OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: Styles.borderRadius8,
    borderSide: BorderSide(color: AppTheme.primary, width: 1.8.w),
  );

  static final OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderRadius: Styles.borderRadius8,
    borderSide:
        BorderSide(color: AppTheme.grey.withValues(alpha: .2), width: 1.8.w),
  );
}
