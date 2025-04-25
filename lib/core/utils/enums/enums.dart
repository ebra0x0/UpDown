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
  doorNotOpening,
  stuckBetweenFloors,
  noise,
  notResponding,
  buttonNotResponding,
  aboveFloor,
  other
}

enum UnitStatus { active, needsMaintenance, outOfService }

enum MediaType { image, video, other }
