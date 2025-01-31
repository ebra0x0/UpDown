import 'package:intl/intl.dart';

String statusDescrition(
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
