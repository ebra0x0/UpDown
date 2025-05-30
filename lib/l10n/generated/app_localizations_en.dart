// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get elevator_working => 'Working';

  @override
  String get elevator_broken => 'Broken';

  @override
  String get elevator_repair => 'Under Repair';

  @override
  String get elevator_maintenance => 'Under Maintenance';

  @override
  String get elevator_disabled => 'Disabled';

  @override
  String get elevatorWorkingDescription => 'The elevator\'s working';

  @override
  String get elevatorBrokenDescription =>
      'The elevator\'s broken and cannot be used';

  @override
  String get elevatorRepairDescription => 'The elevator\'s under repair';

  @override
  String get elevatorMaintenanceDescription =>
      'The elevator\'s under maintenance';

  @override
  String get elevatorDisabledDescription =>
      'The elevator\'s currently unavailable';

  @override
  String get issueType_door_not_opening => 'Door Not Opening';

  @override
  String get issueType_stuck_between_floors => 'Stuck Between Floors';

  @override
  String get issueType_noise => 'Noise';

  @override
  String get issueType_not_responding => 'Not Responding';

  @override
  String get issueType_button_not_responding => 'Button Not Responding';

  @override
  String get issueType_above_floor => 'Above Floor';

  @override
  String get issueType_other => 'Other';

  @override
  String get issueTypeDoorNotOpeningPriority => 'Critical';

  @override
  String get issueTypeStuckBetweenFloorsPriority => 'Critical';

  @override
  String get issueTypeNoisePriority => 'Low';

  @override
  String get issueTypeNotRespondingPriority => 'Critical';

  @override
  String get issueTypeButtonNotRespondingPriority => 'Moderate';

  @override
  String get issueTypeAboveFloorPriority => 'Critical';

  @override
  String get issueTypeOtherPriority => 'Unknown';

  @override
  String get issueStatus_not_fixed => 'Not Fixed';

  @override
  String get issueStatus_needs_parts => 'Needs Parts';

  @override
  String get issueStatus_escalated => 'Escalated';

  @override
  String get issueStatus_fixed => 'Fixed';

  @override
  String get issueStatusNotFixedDescription =>
      'The issue has not been fixed yet';

  @override
  String get issueStatusNeedsPartsDescription => 'The issue needs parts';

  @override
  String get issueStatusEscalatedDescription =>
      'The issue has been escalated to another technecian';

  @override
  String get issueStatusFixedDescription => 'The issue has been fixed';

  @override
  String get report_pending => 'Pending';

  @override
  String get report_reported => 'Reported';

  @override
  String get report_coming => 'Coming';

  @override
  String get report_arrived => 'Arrived';

  @override
  String get report_in_progress => 'In Progress';

  @override
  String get report_resolved => 'Resolved';

  @override
  String get reportPendingDescription =>
      'The report is pending and hasn\'t been handled yet';

  @override
  String get reportReportedDescription => 'The issue has been reported';

  @override
  String get reportComingDescription => 'The technecian\'s on the way';

  @override
  String get reportArrivedDescription => 'The technician has arrived';

  @override
  String get reportInProgressDescription => 'In progress';

  @override
  String get reportResolvedDescription => 'The issue has been resolved';

  @override
  String get unit_engine_name => 'Engine';

  @override
  String get unit_cabine_name => 'Cabine';

  @override
  String get unit_counter_name => 'Counter';

  @override
  String get unit_wires_name => 'Wires';

  @override
  String get unit_control_name => 'Control Panel';

  @override
  String get unit_active => 'Active';

  @override
  String get unit_needs_maintenance => 'Needs Maintenance';

  @override
  String get unit_out_of_service => 'Out Of Service';
}
