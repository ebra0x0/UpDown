enum ContentStatus { initial, loading, loaded, error, empty }

enum ElevatorStatus {
  working("Working"),
  broken("Broken"),
  repair("Repair"),
  maintenance("Maintenance"),
  disabled("Disabled");

  final String name;
  const ElevatorStatus(this.name);
}

enum ReportStatus { pending, reported, coming, arrived, inProgress, resolved }

enum IssueStatus {
  notFixed("Not_Fixed"),
  needsParts("Needs_Parts"),
  escalated("Escalated"),
  fixed("Fixed");

  final String name;
  const IssueStatus(this.name);
}

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

enum IssuePriority {
  critical("Critical"),
  moderate("Moderate"),
  low("Low");

  final String name;
  const IssuePriority(this.name);
}

enum UnitName {
  engine("engine"),
  cabin("cabin"),
  counter("counter"),
  wires("wires"),
  control("control");

  final String name;
  const UnitName(this.name);
}

enum UnitStatus {
  active("Active"),
  needsMaintenance("Needs_Maintenance"),
  outOfService("Out_Of_Service");

  final String name;
  const UnitStatus(this.name);
}

enum MediaType {
  image("image"),
  video("video"),
  other("other");

  final String name;
  const MediaType(this.name);
}
