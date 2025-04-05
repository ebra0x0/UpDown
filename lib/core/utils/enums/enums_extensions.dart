import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

// Elevator Status Extension
extension ElevatorStatusExtension on ElevatorStatus {
  static ElevatorStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case "working":
        return ElevatorStatus.working;
      case "broken":
        return ElevatorStatus.broken;
      case "repair":
        return ElevatorStatus.repair;
      case "maintenance":
        return ElevatorStatus.maintenance;
      case "disabled":
        return ElevatorStatus.disabled;
      default:
        return ElevatorStatus.working;
    }
  }

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

  String description(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    switch (this) {
      case ElevatorStatus.working:
        return local.elevatorWorkingDescription;
      case ElevatorStatus.broken:
        return local.elevatorBrokenDescription;
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
        return Pallete.lightSuccess;
      case ElevatorStatus.broken:
        return Pallete.lightError;
      case ElevatorStatus.repair:
        return Pallete.lightInfo;
      case ElevatorStatus.maintenance:
        return Pallete.lightWarning;
      case ElevatorStatus.disabled:
        return Pallete.lightSecondary;
    }
  }
}

// Issue Type Extension
extension IssueTypeExtension on IssueType {
  static IssueType fromString(String issueType) {
    switch (issueType.toLowerCase()) {
      case "door_not_opening":
        return IssueType.doorNotOpening;
      case "stuck_between_floors":
        return IssueType.stuckBetweenFloors;
      case "noise":
        return IssueType.noise;
      case "not_responding":
        return IssueType.notResponding;
      case "button_not_responding":
        return IssueType.buttonNotResponding;
      case "above_floor":
        return IssueType.aboveFloor;
      case "other":
        return IssueType.other;
      default:
        return IssueType.other;
    }
  }

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
}

// Issue Status Extension
extension IssueStatusExtension on IssueStatus {
  static IssueStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case "not_fixed":
        return IssueStatus.notFixed;
      case "needs_parts":
        return IssueStatus.needsParts;
      case "escalated":
        return IssueStatus.escalated;
      case "fixed":
        return IssueStatus.fixed;
      default:
        return IssueStatus.notFixed;
    }
  }

  String title(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    switch (this) {
      case IssueStatus.notFixed:
        return local.issue_not_fixed;
      case IssueStatus.needsParts:
        return local.issue_needs_parts;
      case IssueStatus.escalated:
        return local.issue_escalated;
      case IssueStatus.fixed:
        return local.issue_fixed;
    }
  }

  String description(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    switch (this) {
      case IssueStatus.notFixed:
        return local.notFixedDescription;
      case IssueStatus.needsParts:
        return local.needsPartsDescription;
      case IssueStatus.escalated:
        return local.escalatedDescription;
      case IssueStatus.fixed:
        return local.fixedDescription;
    }
  }

  Color get color {
    switch (this) {
      case IssueStatus.notFixed:
        return Pallete.lightError;
      case IssueStatus.needsParts:
        return Pallete.lightInfo;
      case IssueStatus.escalated:
        return Pallete.lightWarning;
      case IssueStatus.fixed:
        return Pallete.lightSuccess;
    }
  }
}

// Report Status Extension
extension ReportStatusExtension on ReportStatus {
  static ReportStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return ReportStatus.pending;
      case "reported":
        return ReportStatus.reported;
      case "coming":
        return ReportStatus.coming;
      case "arrived":
        return ReportStatus.arrived;
      case "in_progress":
        return ReportStatus.inProgress;
      case "resolved":
        return ReportStatus.resolved;
      default:
        return ReportStatus.pending;
    }
  }

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
        return Pallete.lightError;
      case ReportStatus.reported:
        return Pallete.lightError;
      case ReportStatus.coming:
        return Pallete.lightError;
      case ReportStatus.arrived:
        return Pallete.lightInfo;
      case ReportStatus.inProgress:
        return Pallete.lightWarning;
      case ReportStatus.resolved:
        return Pallete.lightSuccess;
    }
  }
}

// Unit Status Extension
extension UnitStatusExtension on UnitStatus {
  static UnitStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case "active":
        return UnitStatus.active;
      case "needs_maintenance":
        return UnitStatus.needsMaintenance;
      case "out_of_service":
        return UnitStatus.outOfService;
      default:
        return UnitStatus.active;
    }
  }

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
        return Pallete.lightSuccess;
      case UnitStatus.needsMaintenance:
        return Pallete.lightWarning;
      case UnitStatus.outOfService:
        return Pallete.lightError;
    }
  }
}
