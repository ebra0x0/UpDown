// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get elevator_working => 'يعمل';

  @override
  String get elevator_broken => 'معطل';

  @override
  String get elevator_repair => 'جاري الإصلاح';

  @override
  String get elevator_maintenance => 'تحت الصيانة';

  @override
  String get elevator_disabled => 'مغلق';

  @override
  String get elevatorWorkingDescription => 'المصعد في حالة جيدة';

  @override
  String get elevatorBrokenDescription => 'هناك عطل سيتم اصلاحه في أقرب وقت';

  @override
  String get elevatorRepairDescription => 'جاري إصلاح العطل';

  @override
  String get elevatorMaintenanceDescription => 'تحت الصيانة';

  @override
  String get elevatorDisabledDescription => 'المصعد مغلق';

  @override
  String get issueType_door_not_opening => 'هناك باب لا يفتح ';

  @override
  String get issueType_stuck_between_floors => 'المصعد متوقف بين طابقين';

  @override
  String get issueType_noise => 'المصعد يصدر أصوات عالية ';

  @override
  String get issueType_not_responding => 'المصعد متوقف ولا يستجيب للطلبات ';

  @override
  String get issueType_button_not_responding => 'هناك زر لا يعمل ';

  @override
  String get issueType_above_floor => 'المصعد يتوقف أعلى الطابق المطلوب ';

  @override
  String get issueType_other => 'أخرى';

  @override
  String get issue_not_fixed => 'لم يتم الإصلاح';

  @override
  String get issue_needs_parts => 'يحتاج إلى قطع غيار';

  @override
  String get issue_escalated => 'تم التصعيد';

  @override
  String get issue_fixed => 'تم الإصلاح';

  @override
  String get notFixedDescription => 'لم تُحل بعد';

  @override
  String get needsPartsDescription => 'تحتاج إلى قطع غيار';

  @override
  String get escalatedDescription => 'تم تصعيد العطل لفني أخر';

  @override
  String get fixedDescription => 'تم إصلاح العطل';

  @override
  String get report_pending => 'قيد المراجعة';

  @override
  String get report_reported => 'تم الإبلاغ';

  @override
  String get report_coming => 'الفني في الطريق';

  @override
  String get report_arrived => 'لقد وصل الفني';

  @override
  String get report_in_progress => 'جاري إصلاح العطل';

  @override
  String get report_resolved => 'تم إصلاح العطل';

  @override
  String get reportPendingDescription => 'التقرير في الانتظار ولم يتم التعامل معه بعد';

  @override
  String get reportReportedDescription => 'تم الإبلاغ عن العطل';

  @override
  String get reportComingDescription => 'الفني في الطريق';

  @override
  String get reportArrivedDescription => 'وصل الفني إلى الموقع';

  @override
  String get reportInProgressDescription => 'جاري إصلاح العطل';

  @override
  String get reportResolvedDescription => 'تم إصلاح العطل';

  @override
  String get unit_active => 'نشط';

  @override
  String get unit_needs_maintenance => 'يحتاج صيانة';

  @override
  String get unit_out_of_service => 'خارج الخدمة';
}
