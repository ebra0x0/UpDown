import 'dart:ui';

import 'package:intl/intl.dart';

import 'pallete.dart';

abstract class StatusHandler {
  static String getStatusDescription(
      {required String status, required DateTime? nextMaintenanceDate}) {
    final String maintanceDate = nextMaintenanceDate == null
        ? "لم يحدد بعد"
        : DateFormat.yMd().format(nextMaintenanceDate);

    switch (status) {
      case "Working":
        return 'الصيانة القادمة: $maintanceDate';
      case "Broken":
        return 'في إنتظار الفني';
      case "Maintenance":
        return 'تحت الصيانة';
      case "Repair":
        return 'وصل الفني وجاري الإصلاح';
      case "Disabled":
        return 'مغلق';
      default:
        return 'الصيانة القادمة: $maintanceDate';
    }
  }

  static String getStatusTitle({required String status}) {
    switch (status) {
      case "Working":
        return 'يعمل';
      case "Broken":
        return 'في إنتظار الفني';
      case "Maintenance":
        return 'تحت الصيانة';
      case "Repair":
        return 'وصل الفني وجاري الإصلاح';
      case "Disabled":
        return 'مغلق';
      default:
        return 'يعمل';
    }
  }

  static Color getStatusColor(String status) {
    switch (status) {
      case "Working":
        return Pallete.success;
      case "Broken":
        return Pallete.error;
      case "Maintenance":
        return Pallete.warning;
      case "Repair":
        return Pallete.info;
      case "Disabled":
        return Pallete.secondary;
      default:
        return Pallete.secondary;
    }
  }
}
