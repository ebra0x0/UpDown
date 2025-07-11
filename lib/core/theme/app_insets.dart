import 'package:flutter/widgets.dart';
import 'app_spacing.dart';

class AppInsets {
  // All
  static final all4 = EdgeInsets.all(AppSpacing.s4);
  static final all6 = EdgeInsets.all(AppSpacing.s6);
  static final all8 = EdgeInsets.all(AppSpacing.s8);
  static final all12 = EdgeInsets.all(AppSpacing.s12);
  static final all14 = EdgeInsets.all(AppSpacing.s14);
  static final all16 = EdgeInsets.all(AppSpacing.s16);
  static final all24 = EdgeInsets.all(AppSpacing.s24);
  static final all32 = EdgeInsets.all(AppSpacing.s32);

  // Horizontal
  static final h4 = EdgeInsets.symmetric(horizontal: AppSpacing.s4);
  static final h8 = EdgeInsets.symmetric(horizontal: AppSpacing.s8);
  static final h12 = EdgeInsets.symmetric(horizontal: AppSpacing.s12);
  static final h16 = EdgeInsets.symmetric(horizontal: AppSpacing.s16);

  // Vertical
  static final v2 = EdgeInsets.symmetric(vertical: AppSpacing.s2);
  static final v4 = EdgeInsets.symmetric(vertical: AppSpacing.s4);
  static final v8 = EdgeInsets.symmetric(vertical: AppSpacing.s8);
  static final v12 = EdgeInsets.symmetric(vertical: AppSpacing.s12);
  static final v16 = EdgeInsets.symmetric(vertical: AppSpacing.s16);

  // Only Top
  static final top4 = EdgeInsets.only(top: AppSpacing.s4);
  static final top8 = EdgeInsets.only(top: AppSpacing.s8);
  static final top12 = EdgeInsets.only(top: AppSpacing.s12);
  static final top16 = EdgeInsets.only(top: AppSpacing.s16);
  static final top26 = EdgeInsets.only(top: AppSpacing.s26);

  // Only Bottom
  static final bottom4 = EdgeInsets.only(bottom: AppSpacing.s4);
  static final bottom8 = EdgeInsets.only(bottom: AppSpacing.s8);
  static final bottom12 = EdgeInsets.only(bottom: AppSpacing.s12);
  static final bottom16 = EdgeInsets.only(bottom: AppSpacing.s16);

  // Only Left
  static final left4 = EdgeInsets.only(left: AppSpacing.s4);
  static final left8 = EdgeInsets.only(left: AppSpacing.s8);
  static final left12 = EdgeInsets.only(left: AppSpacing.s12);
  static final left16 = EdgeInsets.only(left: AppSpacing.s16);

  // Only Right
  static final right4 = EdgeInsets.only(right: AppSpacing.s4);
  static final right8 = EdgeInsets.only(right: AppSpacing.s8);
  static final right12 = EdgeInsets.only(right: AppSpacing.s12);
  static final right16 = EdgeInsets.only(right: AppSpacing.s16);
}
