enum ElevatorStatus {
  working,
  broken,
  repair,
  maintenance,
  disabled;
}

enum ReportStatus { pending, reported, coming, arrived, inProgress, resolved }

enum IssueStatus { notFixed, needsParts, escalated, fixed }

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

enum UnitStatus { active, needsMaintenance, outOfService }

enum MediaType { image, video, other }
