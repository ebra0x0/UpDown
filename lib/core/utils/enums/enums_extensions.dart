import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/l10n/generated/app_localizations.dart';
import 'package:flutter/widgets.dart';

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
        return Styles.checkIcon;
      case ElevatorStatus.broken:
        return Styles.errorOutlineIcon;
      case ElevatorStatus.repair:
        return Styles.maintenanceIcon;
      case ElevatorStatus.maintenance:
        return Styles.maintenanceIcon;
      case ElevatorStatus.disabled:
        return Styles.lockIcon;
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
extension UnitNameExtension on UnitName {
  static UnitName fromString(String name) {
    switch (name.toLowerCase()) {
      case "engine":
        return UnitName.engine;
      case "cabin":
        return UnitName.cabin;
      case "counter":
        return UnitName.counter;
      case "wires":
        return UnitName.wires;
      case "control":
        return UnitName.control;
      default:
        return UnitName.engine;
    }
  }

  String name(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    switch (this) {
      case UnitName.engine:
        return local.unit_engine_name;
      case UnitName.cabin:
        return local.unit_cabin_name;
      case UnitName.counter:
        return local.unit_counter_name;
      case UnitName.wires:
        return local.unit_wires_name;
      case UnitName.control:
        return local.unit_control_name;
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
        return AppTheme.green;
      case UnitStatus.needsMaintenance:
        return AppTheme.yellow;
      case UnitStatus.outOfService:
        return AppTheme.red;
    }
  }
}

// Media Type Extension
extension MediaTypeExtension on MediaType {
  static MediaType fromString(String type) {
    switch (type.toLowerCase()) {
      case "image":
        return MediaType.image;
      case "video":
        return MediaType.video;
      case "other":
        return MediaType.other;
      default:
        return MediaType.other;
    }
  }
}
