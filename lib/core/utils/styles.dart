import 'package:UpDown/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class Styles {
  static final TextStyle textStyle10 = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
  );
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

  static final TextStyle textStyle22 = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle textStyle24 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
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
    Icons.check_circle_rounded,
    color: AppTheme.white,
    size: 24.sp,
  );

  static Icon errorIcon = Icon(
    Icons.error_rounded,
    color: AppTheme.white,
    size: 24.sp,
  );

  static Icon errorOutlineIcon = Icon(
    Icons.error_outline_rounded,
    color: AppTheme.white,
    size: 22.sp,
  );

  static const Icon backIcon = Icon(
    Icons.arrow_back_ios_new_rounded,
    size: 22,
  );

  static Icon forwardIcon = Icon(
    Icons.arrow_forward_ios_rounded,
    color: AppTheme.grey,
    size: 20.sp,
  );

  static Icon circleIcon = Icon(
    Icons.circle,
    size: 12.sp,
  );

  static Icon addPhotoIcon = Icon(
    Icons.add_photo_alternate_outlined,
    color: AppTheme.grey,
    size: 46,
  );

  static Icon cameraIcon = Icon(
    Icons.photo_camera_outlined,
    color: AppTheme.grey,
    size: 60.sp,
  );

  static Icon hideIcon = Icon(
    Icons.visibility_off_outlined,
    color: AppTheme.grey,
    size: 24.sp,
  );

  static Icon showIcon = Icon(
    Icons.visibility_outlined,
    color: AppTheme.grey,
    size: 24.sp,
  );

  static Icon passwordIcon = Icon(
    Icons.password_rounded,
    color: AppTheme.grey,
    size: 24.sp,
  );

  static Icon reportIcon = Icon(
    Icons.assignment_late_outlined,
    color: AppTheme.grey,
    size: 24.sp,
  );

  static Icon stairsIcon = Icon(
    Icons.stairs_outlined,
    color: AppTheme.grey,
    size: 24.sp,
  );

  static Icon elevatorIcon = Icon(
    Icons.elevator_outlined,
    color: AppTheme.grey,
    size: 24.sp,
  );

  static Icon apartmentIcon = Icon(
    Icons.apartment_rounded,
    color: AppTheme.grey,
    size: 24.sp,
  );

  static Icon timerIcon = Icon(
    Icons.timer_outlined,
    color: AppTheme.grey,
    size: 24.sp,
  );

  static Icon maintenanceIcon = Icon(
    Icons.handyman_outlined,
    color: AppTheme.grey,
    size: 24.sp,
  );

  static Icon calendarIcon = Icon(
    Icons.calendar_month_outlined,
    color: AppTheme.grey,
    size: 24.sp,
  );

  static Icon descriptionIcon = Icon(
    Icons.description_outlined,
    color: AppTheme.grey,
    size: 24.sp,
  );

  static Icon addMediaIcon = Icon(
    Icons.add_photo_alternate_outlined,
    color: AppTheme.grey,
    size: 56.sp,
  );

  static Icon groupIcon = Icon(
    Icons.groups_outlined,
    color: AppTheme.grey,
    size: 24.sp,
  );

  static Icon badgeIcon = Icon(
    Icons.badge_outlined,
    color: AppTheme.grey,
    size: 24.sp,
  );

  static Icon lockIcon = Icon(
    Icons.lock,
    color: AppTheme.grey,
    size: 24.sp,
  );

  static Icon homeIcon = Icon(
    Icons.roofing_rounded,
    size: 24.sp,
  );

  static Icon addIcon = Icon(
    Icons.add,
    size: 24.sp,
  );

  static Icon userIcon = Icon(
    Icons.person_outline_rounded,
    size: 24.sp,
  );

  static Icon emailIcon = Icon(
    Icons.email_outlined,
    color: AppTheme.grey,
    size: 24.sp,
  );

  static Icon phoneIcon = Icon(
    Icons.phone_enabled_outlined,
    color: AppTheme.grey,
    size: 24.sp,
  );

  static Icon locationIcon = Icon(
    Icons.location_on_outlined,
    color: AppTheme.grey,
    size: 24.sp,
  );

  static Icon logoutIcon = Icon(
    Icons.logout_outlined,
    color: AppTheme.grey,
    size: 24.sp,
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

  static BoxShadow boxShadow = BoxShadow(
    color: Color(0xFFE0E0E0).withValues(alpha: 0.3),
    blurRadius: 10,
    offset: Offset(0, 2),
  );

  // Border
  static final Border generalBoxBorder = Border.all(
    color: AppTheme.red.withValues(
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

  static final OutlineInputBorder generalBorder = OutlineInputBorder(
    borderRadius: Styles.borderRadius8,
    borderSide:
        BorderSide(color: AppTheme.grey.withValues(alpha: .2), width: 1.3.w),
  );

  static final OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: Styles.borderRadius8,
    borderSide: BorderSide(color: AppTheme.red, width: 1.3.w),
  );

  static final OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: Styles.borderRadius8,
    borderSide: BorderSide(color: AppTheme.primary, width: 1.3.w),
  );

  static final OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderRadius: Styles.borderRadius8,
    borderSide:
        BorderSide(color: AppTheme.grey.withValues(alpha: .2), width: 1.3.w),
  );
}
