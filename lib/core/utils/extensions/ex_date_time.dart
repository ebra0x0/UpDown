import 'package:UpDown/core/utils/localization/local_service.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get locale => LocaleService.currentLocale;
  String toDateTimeFormat() {
    return DateFormat('d MMMM, hh:mm a', locale).format(this);
  }

  String toDateFormat() {
    return DateFormat('d MMMM').format(this);
  }

  String toTimeFormat() {
    return DateFormat('hh:mm a').format(this);
  }
}
