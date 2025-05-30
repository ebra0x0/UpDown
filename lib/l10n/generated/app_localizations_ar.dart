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
  String get issueType_door_not_opening => 'هناك باب لا يفتح';

  @override
  String get issueType_stuck_between_floors => 'المصعد متوقف بين طابقين';

  @override
  String get issueType_noise => 'المصعد يصدر أصوات عالية';

  @override
  String get issueType_not_responding => 'المصعد متوقف ولا يستجيب للطلبات';

  @override
  String get issueType_button_not_responding => 'هناك زر لا يعمل ';

  @override
  String get issueType_above_floor => 'المصعد يتوقف أعلى الطابق المطلوب';

  @override
  String get issueType_other => 'أخرى';

  @override
  String get issueTypeDoorNotOpeningPriority => 'حرج';

  @override
  String get issueTypeStuckBetweenFloorsPriority => 'حرج';

  @override
  String get issueTypeNoisePriority => 'منخفض';

  @override
  String get issueTypeNotRespondingPriority => 'حرج';

  @override
  String get issueTypeButtonNotRespondingPriority => 'متوسط';

  @override
  String get issueTypeAboveFloorPriority => 'حرج';

  @override
  String get issueTypeOtherPriority => 'غير محدد';

  @override
  String get issueStatus_not_fixed => 'لم يتم الإصلاح';

  @override
  String get issueStatus_needs_parts => 'قطع غيار ناقصة';

  @override
  String get issueStatus_escalated => 'كلفت لفني أخر';

  @override
  String get issueStatus_fixed => 'تم الإصلاح';

  @override
  String get issueStatusNotFixedDescription => 'لم تُحل بعد';

  @override
  String get issueStatusNeedsPartsDescription => 'تحتاج إلى قطع غيار';

  @override
  String get issueStatusEscalatedDescription => 'تم تصعيد العطل لفني أخر';

  @override
  String get issueStatusFixedDescription => 'تم إصلاح العطل';

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
  String get reportPendingDescription =>
      'التقرير في الانتظار ولم يتم التعامل معه بعد';

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
  String get unit_engine_name => 'الماكينة';

  @override
  String get unit_cabine_name => 'الكابينة';

  @override
  String get unit_counter_name => 'التقل';

  @override
  String get unit_wires_name => 'الحبال';

  @override
  String get unit_control_name => 'الكنترول';

  @override
  String get unit_active => 'نشط';

  @override
  String get unit_needs_maintenance => 'يحتاج صيانة';

  @override
  String get unit_out_of_service => 'خارج الخدمة';
}
