import 'package:UpDown/core/storage/hive/hive_type_ids.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'enums.g.dart';

enum ContentStatus { initial, loading, loaded, error, empty, updated, updating }

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unAuthenticated,
  unconfirmed,
  firstTime,
  error
}

@HiveType(typeId: HiveTypeIds.elevatorStatusEnum)
@JsonEnum(valueField: 'name')
enum ElevatorStatus {
  @HiveField(0)
  working("Working"),
  @HiveField(1)
  broken("Broken"),
  @HiveField(2)
  repair("Repair"),
  @HiveField(3)
  maintenance("Maintenance"),
  @HiveField(4)
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

@HiveType(typeId: HiveTypeIds.issueStatusEnum)
@JsonEnum(valueField: 'name')
enum IssueStatus {
  @HiveField(0)
  notFixed("Not_Fixed"),
  @HiveField(1)
  needsParts("Needs_Parts"),
  @HiveField(2)
  escalated("Escalated"),
  @HiveField(3)
  fixed("Fixed");

  final String name;
  const IssueStatus(this.name);
}

@HiveType(typeId: HiveTypeIds.issueTypeEnum)
@JsonEnum(valueField: 'name')
enum IssueType {
  @HiveField(0)
  doorNotOpening("Door_Not_Opening"),
  @HiveField(1)
  stuckBetweenFloors("Stuck_Between_Floors"),
  @HiveField(2)
  noise("Noise"),
  @HiveField(3)
  notResponding("Not_Responding"),
  @HiveField(4)
  buttonNotResponding("Button_Not_Responding"),
  @HiveField(5)
  aboveFloor("Above_Floor"),
  @HiveField(6)
  other("Other");

  final String name;
  const IssueType(this.name);
}

@HiveType(typeId: HiveTypeIds.issuePriorityEnum)
@JsonEnum(valueField: 'name')
enum IssuePriority {
  @HiveField(0)
  critical("Critical"),
  @HiveField(1)
  moderate("Moderate"),
  @HiveField(2)
  low("Low");

  final String name;
  const IssuePriority(this.name);
}

@HiveType(typeId: HiveTypeIds.unitTypeEnum)
@JsonEnum(valueField: 'name')
enum UnitType {
  @HiveField(0)
  engine("Engine"),
  @HiveField(1)
  cabin("Cabin"),
  @HiveField(2)
  counter("Counter"),
  @HiveField(3)
  wires("Wires"),
  @HiveField(4)
  control("Control");

  final String name;
  const UnitType(this.name);
}

@HiveType(typeId: HiveTypeIds.unitStatusEnum)
@JsonEnum(valueField: 'name')
enum UnitStatus {
  @HiveField(0)
  active("Active"),
  @HiveField(1)
  maintenance("Maintenance"),
  @HiveField(2)
  outOfService("Out_Of_Service"),
  @HiveField(3)
  requiresReplacement("Requires_Replacement");

  final String name;
  const UnitStatus(this.name);
}

@HiveType(typeId: HiveTypeIds.floorStatusEnum)
@JsonEnum(valueField: 'name')
enum FloorStatus {
  @HiveField(0)
  accessible("Accessible"),
  @HiveField(1)
  outOfService("Out_Of_Service"),
  @HiveField(2)
  closed("Closed"),
  @HiveField(3)
  restricted("Restricted");

  final String name;
  const FloorStatus(this.name);
}

@HiveType(typeId: HiveTypeIds.doorStatusEnum)
@JsonEnum(valueField: 'name')
enum DoorStatus {
  @HiveField(0)
  active("Active"),
  @HiveField(1)
  outOfService("Out_Of_Service"),
  @HiveField(2)
  locked("Locked");

  final String name;
  const DoorStatus(this.name);
}

@HiveType(typeId: HiveTypeIds.partTypeEnum)
@JsonEnum(valueField: 'name')
enum PartType {
  @HiveField(0)
  doorLock("Door_Lock"),
  @HiveField(1)
  doorPump("Door_Pump"),
  @HiveField(2)
  doorSpring("Door_Spring");

  final String name;
  const PartType(this.name);
}

@HiveType(typeId: HiveTypeIds.partConditionEnum)
@JsonEnum(valueField: 'name')
enum PartCondition {
  @HiveField(0)
  good("Good"),
  @HiveField(1)
  worn("Worn"),
  @HiveField(2)
  broken("Broken");

  final String name;
  const PartCondition(this.name);
}

@HiveType(typeId: HiveTypeIds.mediaTypeEnum)
@JsonEnum(valueField: 'name')
enum MediaType {
  @HiveField(0)
  image("image"),
  @HiveField(1)
  video("video"),
  @HiveField(2)
  other("other");

  final String name;
  const MediaType(this.name);
}
