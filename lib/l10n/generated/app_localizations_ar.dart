// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get elevator_status_working => 'يعمل';

  @override
  String get elevator_status_broken => 'معطل';

  @override
  String get elevator_status_repair => 'جاري الإصلاح';

  @override
  String get elevator_status_maintenance => 'تحت الصيانة';

  @override
  String get elevator_status_disabled => 'مغلق';

  @override
  String get elevator_description_Working => 'المصعد في حالة جيدة';

  @override
  String get elevator_description_Broken => 'هناك عطل سيتم اصلاحه في أقرب وقت';

  @override
  String get elevator_description_Repair => 'جاري إصلاح العطل';

  @override
  String get elevator_description_Maintenance => 'تحت الصيانة';

  @override
  String get elevator_description_Disabled => 'المصعد مغلق';

  @override
  String get issue_type_door_not_opening => 'هناك باب لا يفتح';

  @override
  String get issue_type_stuck_between_floors => 'المصعد متوقف بين طابقين';

  @override
  String get issue_type_noise => 'المصعد يصدر أصوات عالية';

  @override
  String get issue_type_not_responding => 'المصعد متوقف ولا يستجيب للطلبات';

  @override
  String get issue_type_button_not_responding => 'هناك زر لا يعمل ';

  @override
  String get issue_type_above_floor => 'المصعد يتوقف أعلى الطابق المطلوب';

  @override
  String get issue_type_other => 'أخرى';

  @override
  String get issue_type_priority_DoorNotOpening => 'حرج';

  @override
  String get issue_type_priority_StuckBetweenFloors => 'حرج';

  @override
  String get issue_type_priority_Noise => 'منخفض';

  @override
  String get issue_type_priority_NotResponding => 'حرج';

  @override
  String get issue_type_priority_ButtonNotResponding => 'متوسط';

  @override
  String get issue_type_priority_AboveFloor => 'حرج';

  @override
  String get issue_type_priority_Other => 'غير محدد';

  @override
  String get issue_status_not_fixed => 'لم يتم الإصلاح';

  @override
  String get issue_status_needs_parts => 'قطع غيار ناقصة';

  @override
  String get issue_status_escalated => 'كلفت لفني أخر';

  @override
  String get issue_status_fixed => 'تم الإصلاح';

  @override
  String get issue_description_NotFixed => 'لم تُحل بعد';

  @override
  String get issue_description_NeedsParts => 'تحتاج إلى قطع غيار';

  @override
  String get issue_description_Escalated => 'تم تصعيد العطل لفني أخر';

  @override
  String get issue_description_Fixed => 'تم إصلاح العطل';

  @override
  String get report_status_pending => 'قيد المراجعة';

  @override
  String get report_status_reported => 'تم الإبلاغ';

  @override
  String get report_status_coming => 'الفني في الطريق';

  @override
  String get report_status_arrived => 'لقد وصل الفني';

  @override
  String get report_status_in_progress => 'جاري إصلاح العطل';

  @override
  String get report_status_resolved => 'تم إصلاح العطل';

  @override
  String get report_description_Pending => 'التقرير في الانتظار ولم يتم التعامل معه بعد';

  @override
  String get report_description_Reported => 'تم الإبلاغ عن العطل';

  @override
  String get report_description_Coming => 'الفني في الطريق';

  @override
  String get report_description_Arrived => 'وصل الفني إلى الموقع';

  @override
  String get report_description_InProgress => 'جاري إصلاح العطل';

  @override
  String get report_description_Resolved => 'تم إصلاح جميع الأعطال';

  @override
  String get unit_name_engine => 'الماكينة';

  @override
  String get unit_name_cabin => 'الكابينة';

  @override
  String get unit_name_counter => 'التقل';

  @override
  String get unit_name_wires => 'الحبال';

  @override
  String get unit_name_control => 'الكنترول';

  @override
  String get unit_status_active => 'نشط';

  @override
  String get unit_status_maintenance => 'تحت الصيانة';

  @override
  String get unit_status_out_of_service => 'خارج الخدمة';

  @override
  String get unit_status_requires_replacement => 'مطلوب استبداله';

  @override
  String get floor_status_accessible => 'متاح';

  @override
  String get floor_status_out_of_service => 'خارج الخدمة';

  @override
  String get floor_status_closed => 'مغلق';

  @override
  String get floor_status_restricted => 'خاص';

  @override
  String get part_type_door_lock => 'كالون';

  @override
  String get part_type_door_pump => 'طلمبة';

  @override
  String get part_type_door_spring => 'سوستة';

  @override
  String get part_condition_good => 'جيد';

  @override
  String get part_condition_worn => 'مستعمل';

  @override
  String get part_condition_broken => 'تالف';
}
