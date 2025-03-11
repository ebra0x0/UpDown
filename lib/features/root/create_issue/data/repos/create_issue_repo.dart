import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/features/root/home/data/model/building_summary_model.dart';
import 'package:UpDown/features/root/home/data/model/elevator_summary_model.dart';
import 'package:either_dart/either.dart';

abstract class CreateIssueRepo {
  CreateIssueRepo(
      {this.selectedBuilding,
      this.selectedElevator,
      this.issueType,
      this.description});

  BuildingSummaryModel? selectedBuilding;
  ElevatorSummaryModel? selectedElevator;
  String? issueType;
  String? description;

  Future<Either<Failure, void>> createIssue();
}
