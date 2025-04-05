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
  String get elevatorWorkingDescription => 'The elevator is in good condition and working normally.';

  @override
  String get elevatorBrokenDescription => 'The elevator is broken and cannot be used.';

  @override
  String get elevatorRepairDescription => 'The elevator is under repair.';

  @override
  String get elevatorMaintenanceDescription => 'The elevator is under maintenance.';

  @override
  String get elevatorDisabledDescription => 'The elevator is currently unavailable.';

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
  String get issue_not_fixed => 'Not Fixed';

  @override
  String get issue_needs_parts => 'Needs Parts';

  @override
  String get issue_escalated => 'Escalated';

  @override
  String get issue_fixed => 'Fixed';

  @override
  String get notFixedDescription => 'The issue has not been fixed yet.';

  @override
  String get needsPartsDescription => 'The issue needs parts.';

  @override
  String get escalatedDescription => 'The issue has been escalated to a higher level.';

  @override
  String get fixedDescription => 'The issue has been fixed.';

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
  String get reportPendingDescription => 'The report is pending and hasn\'t been handled yet.';

  @override
  String get reportReportedDescription => 'The issue has been reported.';

  @override
  String get reportComingDescription => 'The experts are on their way to solve the issue.';

  @override
  String get reportArrivedDescription => 'The experts have arrived at the location.';

  @override
  String get reportInProgressDescription => 'The issue is being worked on.';

  @override
  String get reportResolvedDescription => 'The issue has been resolved.';

  @override
  String get unit_active => 'Active';

  @override
  String get unit_needs_maintenance => 'Needs Maintenance';

  @override
  String get unit_out_of_service => 'Out Of Service';
}
