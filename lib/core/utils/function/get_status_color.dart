import 'dart:ui';
import '../pallete.dart';

Color getStatusColor(String status) {
  switch (status) {
    case "Working":
      return Pallete.lightSuccess;
    case "Broken":
      return Pallete.lightError;
    case "Maintenance":
      return Pallete.lightWarning;
    case "Repair":
      return Pallete.lightInfo;
    case "Disabled":
      return Pallete.lightSecondary;
    default:
      return Pallete.lightSecondary;
  }
}
