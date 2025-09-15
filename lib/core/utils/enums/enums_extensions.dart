import 'package:UpDown/core/assets/app_assets.dart';
import 'package:UpDown/core/theme/app_icons.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/enums/enums.dart';

import 'package:UpDown/l10n/generated/app_localizations.dart';
import 'package:flutter/widgets.dart';

// Elevator Status Extension
extension ElevatorStatusExtension on ElevatorStatus {
  String title(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    switch (this) {
      case ElevatorStatus.working:
        return local.elevator_status_working;
      case ElevatorStatus.broken:
        return local.elevator_status_broken;
      case ElevatorStatus.repair:
        return local.elevator_status_repair;
      case ElevatorStatus.maintenance:
        return local.elevator_status_maintenance;
      case ElevatorStatus.disabled:
        return local.elevator_status_disabled;
    }
  }

  String description(BuildContext context, IssueType? issueType) {
    final local = AppLocalizations.of(context)!;
    switch (this) {
      case ElevatorStatus.working:
        return local.elevator_description_Working;
      case ElevatorStatus.broken:
        return issueType!.title(context);
      case ElevatorStatus.repair:
        return local.elevator_description_Repair;
      case ElevatorStatus.maintenance:
        return local.elevator_description_Maintenance;
      case ElevatorStatus.disabled:
        return local.elevator_description_Disabled;
    }
  }

  Color get color {
    switch (this) {
      case ElevatorStatus.working:
        return AppTheme.green;
      case ElevatorStatus.broken:
        return AppTheme.red;
      case ElevatorStatus.repair:
        return AppTheme.blue;
      case ElevatorStatus.maintenance:
        return AppTheme.yellow;
      case ElevatorStatus.disabled:
        return AppTheme.grey;
    }
  }

  Icon get icon {
    switch (this) {
      case ElevatorStatus.working:
        return AppIcons.checkIcon;
      case ElevatorStatus.broken:
        return AppIcons.errorOutlineIcon;
      case ElevatorStatus.repair:
        return AppIcons.maintenanceIcon;
      case ElevatorStatus.maintenance:
        return AppIcons.maintenanceIcon;
      case ElevatorStatus.disabled:
        return AppIcons.lockIcon;
    }
  }
}

// Issue Type Extension
extension IssueTypeExtension on IssueType {
  String title(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    switch (this) {
      case IssueType.doorNotOpening:
        return local.issue_type_door_not_opening;
      case IssueType.stuckBetweenFloors:
        return local.issue_type_stuck_between_floors;
      case IssueType.noise:
        return local.issue_type_noise;
      case IssueType.notResponding:
        return local.issue_type_not_responding;
      case IssueType.buttonNotResponding:
        return local.issue_type_button_not_responding;
      case IssueType.aboveFloor:
        return local.issue_type_above_floor;
      case IssueType.other:
        return local.issue_type_other;
    }
  }

  String priority(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    switch (this) {
      case IssueType.doorNotOpening:
        return local.issue_type_priority_DoorNotOpening;
      case IssueType.stuckBetweenFloors:
        return local.issue_type_priority_StuckBetweenFloors;
      case IssueType.noise:
        return local.issue_type_priority_Noise;
      case IssueType.notResponding:
        return local.issue_type_priority_NotResponding;
      case IssueType.buttonNotResponding:
        return local.issue_type_priority_ButtonNotResponding;
      case IssueType.aboveFloor:
        return local.issue_type_priority_AboveFloor;
      case IssueType.other:
        return local.issue_type_priority_Other;
    }
  }

  Icon get icon {
    switch (this) {
      case IssueType.doorNotOpening:
        return AppIcons.doorLockedIcon;
      case IssueType.stuckBetweenFloors:
        return AppIcons.betweenIcon;
      case IssueType.noise:
        return AppIcons.volumeUpIcon;
      case IssueType.notResponding:
        return AppIcons.powerIcon;
      case IssueType.buttonNotResponding:
        return AppIcons.buttonIcon;
      case IssueType.aboveFloor:
        return AppIcons.aboveFloorIcon;
      case IssueType.other:
        return AppIcons.reportProblemIcon;
    }
  }
}

// Issue Status Extension
extension IssueStatusExtension on IssueStatus {
  String title(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    switch (this) {
      case IssueStatus.notFixed:
        return local.issue_status_not_fixed;
      case IssueStatus.needsParts:
        return local.issue_status_needs_parts;
      case IssueStatus.escalated:
        return local.issue_status_escalated;
      case IssueStatus.fixed:
        return local.issue_status_fixed;
    }
  }

  String description(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    switch (this) {
      case IssueStatus.notFixed:
        return local.issue_description_NotFixed;
      case IssueStatus.needsParts:
        return local.issue_description_NeedsParts;
      case IssueStatus.escalated:
        return local.issue_description_Escalated;
      case IssueStatus.fixed:
        return local.issue_description_Fixed;
    }
  }

  Color get color {
    switch (this) {
      case IssueStatus.notFixed:
        return AppTheme.red;
      case IssueStatus.needsParts:
        return AppTheme.blue;
      case IssueStatus.escalated:
        return AppTheme.yellow;
      case IssueStatus.fixed:
        return AppTheme.green;
    }
  }
}

// Report Status Extension
extension ReportStatusExtension on ReportStatus {
  String title(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    switch (this) {
      case ReportStatus.pending:
        return local.report_status_pending;
      case ReportStatus.reported:
        return local.report_status_reported;
      case ReportStatus.coming:
        return local.report_status_coming;
      case ReportStatus.arrived:
        return local.report_status_arrived;
      case ReportStatus.inProgress:
        return local.report_status_in_progress;
      case ReportStatus.resolved:
        return local.report_status_resolved;
    }
  }

  String description(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    switch (this) {
      case ReportStatus.pending:
        return local.report_description_Pending;
      case ReportStatus.reported:
        return local.report_description_Reported;
      case ReportStatus.coming:
        return local.report_description_Coming;
      case ReportStatus.arrived:
        return local.report_description_Arrived;
      case ReportStatus.inProgress:
        return local.report_description_InProgress;
      case ReportStatus.resolved:
        return local.report_description_Resolved;
    }
  }

  Color get color {
    switch (this) {
      case ReportStatus.pending:
        return AppTheme.grey;
      case ReportStatus.reported:
        return AppTheme.red;
      case ReportStatus.coming:
        return AppTheme.red;
      case ReportStatus.arrived:
        return AppTheme.blue;
      case ReportStatus.inProgress:
        return AppTheme.yellow;
      case ReportStatus.resolved:
        return AppTheme.green;
    }
  }
}

// Unit Type Extension
extension UnitTypeExtension on UnitType {
  String title(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    switch (this) {
      case UnitType.engine:
        return local.unit_name_engine;
      case UnitType.cabin:
        return local.unit_name_cabin;
      case UnitType.counter:
        return local.unit_name_counter;
      case UnitType.wires:
        return local.unit_name_wires;
      case UnitType.control:
        return local.unit_name_control;
    }
  }

  String assetPath() {
    switch (this) {
      case UnitType.engine:
        return AppAssets.engine;
      case UnitType.cabin:
        return AppAssets.cabin;
      case UnitType.counter:
        return AppAssets.counter;
      case UnitType.wires:
        return AppAssets.wires;
      case UnitType.control:
        return AppAssets.control;
    }
  }
}

// Unit Status Extension
extension UnitStatusExtension on UnitStatus {
  String title(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    switch (this) {
      case UnitStatus.active:
        return local.unit_status_active;
      case UnitStatus.maintenance:
        return local.unit_status_maintenance;
      case UnitStatus.outOfService:
        return local.unit_status_out_of_service;
      case UnitStatus.requiresReplacement:
        return local.unit_status_requires_replacement;
    }
  }

  Color get color {
    switch (this) {
      case UnitStatus.active:
        return AppTheme.green;
      case UnitStatus.maintenance:
        return AppTheme.yellow;
      case UnitStatus.outOfService:
        return AppTheme.red;
      case UnitStatus.requiresReplacement:
        return AppTheme.blue;
    }
  }
}

extension FloorStatusExtension on FloorStatus {
  String title(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    switch (this) {
      case FloorStatus.accessible:
        return local.floor_status_accessible;
      case FloorStatus.outOfService:
        return local.floor_status_out_of_service;
      case FloorStatus.closed:
        return local.floor_status_closed;
      case FloorStatus.restricted:
        return local.floor_status_restricted;
    }
  }

  Color get color {
    switch (this) {
      case FloorStatus.accessible:
        return AppTheme.green;
      case FloorStatus.outOfService:
        return AppTheme.red;
      case FloorStatus.closed:
        return AppTheme.grey;
      case FloorStatus.restricted:
        return AppTheme.blue;
    }
  }
}

extension PartTypeExtension on PartType {
  String title(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    switch (this) {
      case PartType.doorLock:
        return local.part_type_door_lock;
      case PartType.doorPump:
        return local.part_type_door_pump;
      case PartType.doorSpring:
        return local.part_type_door_spring;
    }
  }
}

extension PartConditionExtension on PartCondition {
  String title(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    switch (this) {
      case PartCondition.good:
        return local.part_condition_good;
      case PartCondition.worn:
        return local.part_condition_worn;
      case PartCondition.broken:
        return local.part_condition_broken;
    }
  }

  Color get color {
    switch (this) {
      case PartCondition.good:
        return AppTheme.green;
      case PartCondition.worn:
        return AppTheme.yellow;
      case PartCondition.broken:
        return AppTheme.red;
    }
  }
}
