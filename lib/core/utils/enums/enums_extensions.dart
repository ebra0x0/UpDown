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
        return local.elevator_working;
      case ElevatorStatus.broken:
        return local.elevator_broken;
      case ElevatorStatus.repair:
        return local.elevator_repair;
      case ElevatorStatus.maintenance:
        return local.elevator_maintenance;
      case ElevatorStatus.disabled:
        return local.elevator_disabled;
    }
  }

  String description(BuildContext context, IssueType? issueType) {
    final local = AppLocalizations.of(context)!;
    switch (this) {
      case ElevatorStatus.working:
        return local.elevatorWorkingDescription;
      case ElevatorStatus.broken:
        return issueType!.title(context);
      case ElevatorStatus.repair:
        return local.elevatorRepairDescription;
      case ElevatorStatus.maintenance:
        return local.elevatorMaintenanceDescription;
      case ElevatorStatus.disabled:
        return local.elevatorDisabledDescription;
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
        return local.issueType_door_not_opening;
      case IssueType.stuckBetweenFloors:
        return local.issueType_stuck_between_floors;
      case IssueType.noise:
        return local.issueType_noise;
      case IssueType.notResponding:
        return local.issueType_not_responding;
      case IssueType.buttonNotResponding:
        return local.issueType_button_not_responding;
      case IssueType.aboveFloor:
        return local.issueType_above_floor;
      case IssueType.other:
        return local.issueType_other;
    }
  }

  String priority(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    switch (this) {
      case IssueType.doorNotOpening:
        return local.issueTypeDoorNotOpeningPriority;
      case IssueType.stuckBetweenFloors:
        return local.issueTypeStuckBetweenFloorsPriority;
      case IssueType.noise:
        return local.issueTypeNoisePriority;
      case IssueType.notResponding:
        return local.issueTypeNotRespondingPriority;
      case IssueType.buttonNotResponding:
        return local.issueTypeButtonNotRespondingPriority;
      case IssueType.aboveFloor:
        return local.issueTypeAboveFloorPriority;
      case IssueType.other:
        return local.issueTypeOtherPriority;
    }
  }
}

// Issue Status Extension
extension IssueStatusExtension on IssueStatus {
  String title(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    switch (this) {
      case IssueStatus.notFixed:
        return local.issueStatus_not_fixed;
      case IssueStatus.needsParts:
        return local.issueStatus_needs_parts;
      case IssueStatus.escalated:
        return local.issueStatus_escalated;
      case IssueStatus.fixed:
        return local.issueStatus_fixed;
    }
  }

  String description(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    switch (this) {
      case IssueStatus.notFixed:
        return local.issueStatusNotFixedDescription;
      case IssueStatus.needsParts:
        return local.issueStatusNeedsPartsDescription;
      case IssueStatus.escalated:
        return local.issueStatusEscalatedDescription;
      case IssueStatus.fixed:
        return local.issueStatusFixedDescription;
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
        return local.report_pending;
      case ReportStatus.reported:
        return local.report_reported;
      case ReportStatus.coming:
        return local.report_coming;
      case ReportStatus.arrived:
        return local.report_arrived;
      case ReportStatus.inProgress:
        return local.report_in_progress;
      case ReportStatus.resolved:
        return local.report_resolved;
    }
  }

  String description(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    switch (this) {
      case ReportStatus.pending:
        return local.reportPendingDescription;
      case ReportStatus.reported:
        return local.reportReportedDescription;
      case ReportStatus.coming:
        return local.reportComingDescription;
      case ReportStatus.arrived:
        return local.reportArrivedDescription;
      case ReportStatus.inProgress:
        return local.reportInProgressDescription;
      case ReportStatus.resolved:
        return local.reportResolvedDescription;
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

// Unit Name Extension
extension UnitTypeExtension on UnitType {
  String title(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    switch (this) {
      case UnitType.engine:
        return local.unit_engine_name;
      case UnitType.cabin:
        return local.unit_cabin_name;
      case UnitType.counter:
        return local.unit_counter_name;
      case UnitType.wires:
        return local.unit_wires_name;
      case UnitType.control:
        return local.unit_control_name;
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
        return local.unit_active;
      case UnitStatus.needsMaintenance:
        return local.unit_needs_maintenance;
      case UnitStatus.outOfService:
        return local.unit_out_of_service;
    }
  }

  Color get color {
    switch (this) {
      case UnitStatus.active:
        return AppTheme.green;
      case UnitStatus.needsMaintenance:
        return AppTheme.yellow;
      case UnitStatus.outOfService:
        return AppTheme.red;
    }
  }
}
