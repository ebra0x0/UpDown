// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get elevator_status_working => 'Working';

  @override
  String get elevator_status_broken => 'Broken';

  @override
  String get elevator_status_repair => 'Under Repair';

  @override
  String get elevator_status_maintenance => 'Under Maintenance';

  @override
  String get elevator_status_disabled => 'Disabled';

  @override
  String get elevator_description_Working => 'The elevator\'s working';

  @override
  String get elevator_description_Broken => 'The elevator\'s broken and cannot be used';

  @override
  String get elevator_description_Repair => 'The elevator\'s under repair';

  @override
  String get elevator_description_Maintenance => 'The elevator\'s under maintenance';

  @override
  String get elevator_description_Disabled => 'The elevator\'s currently unavailable';

  @override
  String get issue_type_door_not_opening => 'Door Not Opening';

  @override
  String get issue_type_stuck_between_floors => 'Stuck Between Floors';

  @override
  String get issue_type_noise => 'Noise';

  @override
  String get issue_type_not_responding => 'Not Responding';

  @override
  String get issue_type_button_not_responding => 'Button Not Responding';

  @override
  String get issue_type_above_floor => 'Above Floor';

  @override
  String get issue_type_other => 'Other';

  @override
  String get issue_type_priority_DoorNotOpening => 'Critical';

  @override
  String get issue_type_priority_StuckBetweenFloors => 'Critical';

  @override
  String get issue_type_priority_Noise => 'Low';

  @override
  String get issue_type_priority_NotResponding => 'Critical';

  @override
  String get issue_type_priority_ButtonNotResponding => 'Moderate';

  @override
  String get issue_type_priority_AboveFloor => 'Critical';

  @override
  String get issue_type_priority_Other => 'Unknown';

  @override
  String get issue_status_not_fixed => 'Not Fixed';

  @override
  String get issue_status_needs_parts => 'Needs Parts';

  @override
  String get issue_status_escalated => 'Escalated';

  @override
  String get issue_status_fixed => 'Fixed';

  @override
  String get issue_description_NotFixed => 'The issue has not been fixed yet';

  @override
  String get issue_description_NeedsParts => 'The issue needs parts';

  @override
  String get issue_description_Escalated => 'The issue has been escalated to another technecian';

  @override
  String get issue_description_Fixed => 'The issue has been fixed';

  @override
  String get report_status_pending => 'Pending';

  @override
  String get report_status_reported => 'Reported';

  @override
  String get report_status_coming => 'Coming';

  @override
  String get report_status_arrived => 'Arrived';

  @override
  String get report_status_in_progress => 'In Progress';

  @override
  String get report_status_resolved => 'Resolved';

  @override
  String get report_description_Pending => 'The report is pending and hasn\'t been handled yet';

  @override
  String get report_description_Reported => 'The issue has been reported';

  @override
  String get report_description_Coming => 'The technecian\'s on the way';

  @override
  String get report_description_Arrived => 'The technician has arrived';

  @override
  String get report_description_InProgress => 'In progress';

  @override
  String get report_description_Resolved => 'The issue has been resolved';

  @override
  String get unit_name_engine => 'Engine';

  @override
  String get unit_name_cabin => 'Cabin';

  @override
  String get unit_name_counter => 'Counter';

  @override
  String get unit_name_wires => 'Wires';

  @override
  String get unit_name_control => 'Control control';

  @override
  String get unit_status_active => 'Active';

  @override
  String get unit_status_maintenance => 'Needs Maintenance';

  @override
  String get unit_status_out_of_service => 'Out Of Service';

  @override
  String get unit_status_requires_replacement => 'Requires Replacement';

  @override
  String get floor_status_accessible => 'Accessible';

  @override
  String get floor_status_out_of_service => 'Out Of Service';

  @override
  String get floor_status_closed => 'Closed';

  @override
  String get floor_status_restricted => 'Restricted';

  @override
  String get part_type_door_lock => 'Lock';

  @override
  String get part_type_door_pump => 'Pumb';

  @override
  String get part_type_door_spring => 'Spring';

  @override
  String get part_condition_good => 'Good';

  @override
  String get part_condition_worn => 'Worn';

  @override
  String get part_condition_broken => 'Broken';
}
