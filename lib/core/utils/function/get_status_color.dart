import 'dart:ui';
import '../pallete.dart';

Color getStatusColor(String status) {
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
