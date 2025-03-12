import 'dart:ui';
import 'package:intl/intl.dart';

import 'pallete.dart';

class StatusHandler {
  final String title;
  final String? description;
  final Color color;

  StatusHandler({required this.title, this.description, required this.color});

  factory StatusHandler.fromElevatorStatus(
      {required String status,
      DateTime? nextMaintenanceDate,
      String? issueType}) {
    switch (status) {
      case "Working":
        return StatusHandler(
            title: "يعمل",
            description:
                'الصيانة القادمة: ${nextMaintenanceDate == null ? 'لم يحدد بعد' : DateFormat.yMd().format(nextMaintenanceDate)}',
            color: Pallete.success);
      case "Broken":
        return StatusHandler(
            title: "معطل",
            description: getIssueDescription(issueType: issueType!),
            color: Pallete.error);
      case "Maintenance":
        return StatusHandler(
            title: "تحت الصيانة",
            description: 'تحت الصيانة',
            color: Pallete.warning);
      case "Repair":
        return StatusHandler(
            title: "جاري الإصلاح",
            description: 'وصل الفني وجاري الإصلاح',
            color: Pallete.info);
      case "Disabled":
        return StatusHandler(
            title: "مغلق", description: 'مغلق', color: Pallete.secondary);
      default:
        return StatusHandler(
            title: "يعمل",
            description:
                'الصيانة القادمة: ${nextMaintenanceDate == null ? 'لم يحدد بعد' : DateFormat.yMd().format(nextMaintenanceDate)}',
            color: Pallete.success);
    }
  }

  factory StatusHandler.fromIssueStatus(
      {required String status, required String issueType}) {
    switch (status) {
      case "Not_Fixed":
        return StatusHandler(
            title: getIssueDescription(issueType: issueType),
            description: "سيتم إصلاح العطل في أقرب وقت ممكن",
            color: Pallete.error);
      case "Needs_Parts":
        return StatusHandler(
            title: getIssueDescription(issueType: issueType),
            description: 'في إنتظار توفير قطع الغيار',
            color: Pallete.info);
      case "Escalated":
        return StatusHandler(
            title: getIssueDescription(issueType: issueType),
            description: 'سيتم حلها في وقت لاحق',
            color: Pallete.warning);
      case "Fixed":
        return StatusHandler(
            title: getIssueDescription(issueType: issueType),
            description: 'تم حلها بنجاح',
            color: Pallete.success);
      default:
        return StatusHandler(
            title: getIssueDescription(issueType: issueType),
            description: "سيتم إصلاح العطل في أقرب وقت ممكن",
            color: Pallete.error);
    }
  }
}

String getIssueDescription({required String issueType}) {
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
