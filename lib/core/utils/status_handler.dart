import 'dart:ui';
import 'package:intl/intl.dart';

import 'pallete.dart';

abstract class StatusHandler {
  static String getStatusDescription(
      {required String status,
      String? issueType,
      DateTime? nextMaintenanceDate}) {
    switch (status) {
      case "Working":
        return 'الصيانة القادمة: ${nextMaintenanceDate == null ? 'لم يحدد بعد' : DateFormat.yMd().format(nextMaintenanceDate)}';
      case "Broken":
        return getIssueDescription(issueType: issueType!);
      case "Maintenance":
        return 'جاري صيانة المصعد';
      case "Repair":
        return 'جاري حل مشكلة "${getIssueDescription(issueType: issueType!)}"';
      case "Disabled":
        return 'المصعد مغلق';
      default:
        return 'الصيانة القادمة: ${nextMaintenanceDate == null ? 'لم يحدد بعد' : DateFormat.yMd().format(nextMaintenanceDate)}';
    }
  }

  static String getIssueDescription({required String issueType}) {
    switch (issueType) {
      case "Door_Not_Opening":
        return 'الباب مش بيفتح';
      case "Stuck_Between_Floors":
        return 'واقف بين الأدوار';
      case "Noise":
        return 'فيه صوت غريب';
      case "Not_Responding":
        return 'الأسانسير مش بيتحرك';
      case "Button_Not_Responding":
        return 'الزرار مش شغال';
      case "Above_Floor":
        return 'بيقف بعيد عن الدور';
      case "Other":
        return 'الأسانسير عطلان';
      default:
        return 'الأسانسير عطلان';
    }
  }

  static String getStatusTitle({required String status}) {
    switch (status) {
      case "Working":
        return 'يعمل';
      case "Broken":
        return 'معطل';
      case "Maintenance":
        return 'صيانة';
      case "Repair":
        return 'جاري الإصلاح';
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
