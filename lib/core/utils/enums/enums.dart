import 'package:json_annotation/json_annotation.dart';

enum ContentStatus { initial, loading, loaded, error, empty }

@JsonEnum(valueField: 'name')
enum ElevatorStatus {
  working("Working"),
  broken("Broken"),
  repair("Repair"),
  maintenance("Maintenance"),
  disabled("Disabled");

  final String name;
  const ElevatorStatus(this.name);
}

@JsonEnum(valueField: 'name')
enum ReportStatus {
  pending("Pending"),
  reported("Reported"),
  coming("Coming"),
  arrived("Arrived"),
  inProgress("In_Progress"),
  resolved("Resolved");

  final String name;
  const ReportStatus(this.name);
}

@JsonEnum(valueField: 'name')
enum IssueStatus {
  notFixed("Not_Fixed"),
  needsParts("Needs_Parts"),
  escalated("Escalated"),
  fixed("Fixed");

  final String name;
  const IssueStatus(this.name);
}

@JsonEnum(valueField: 'name')
enum IssueType {
  doorNotOpening("Door_Not_Opening"),
  stuckBetweenFloors("Stuck_Between_Floors"),
  noise("Noise"),
  notResponding("Not_Responding"),
  buttonNotResponding("Button_Not_Responding"),
  aboveFloor("Above_Floor"),
  other("Other");

  final String name;
  const IssueType(this.name);
}

@JsonEnum(valueField: 'name')
enum IssuePriority {
  critical("Critical"),
  moderate("Moderate"),
  low("Low");

  final String name;
  const IssuePriority(this.name);
}

@JsonEnum(valueField: 'name')
enum UnitName {
  engine("engine"),
  cabin("cabin"),
  counter("counter"),
  wires("wires"),
  control("control");

  final String name;
  const UnitName(this.name);
}

@JsonEnum(valueField: 'name')
enum UnitStatus {
  active("Active"),
  needsMaintenance("Needs_Maintenance"),
  outOfService("Out_Of_Service");

  final String name;
  const UnitStatus(this.name);
}

@JsonEnum(valueField: 'name')
enum MediaType {
  image("image"),
  video("video"),
  other("other");

  final String name;
  const MediaType(this.name);
}
