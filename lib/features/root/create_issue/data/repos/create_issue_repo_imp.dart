import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/core/utils/service_locator.dart';
import 'package:UpDown/features/root/create_issue/data/model/issue_model.dart';
import 'package:UpDown/features/root/create_issue/data/repos/create_issue_repo.dart';
import 'package:UpDown/features/root/home/data/model/building_summary_model.dart';
import 'package:UpDown/features/root/home/data/model/elevator_summary_model.dart';
import 'package:either_dart/either.dart';

class CreateIssueRepoImp implements CreateIssueRepo {
  @override
  String? description;

  @override
  String? issueType;

  @override
  BuildingSummaryModel? selectedBuilding;

  @override
  ElevatorSummaryModel? selectedElevator;

  @override
  Future<Either<Failure, void>> createIssue() async {
    IssueModel issueModel = IssueModel.fromJson({
      "issue_type": issueType,
      "description": description,
      "building_id": selectedBuilding?.buildingId,
      "elevator_id": selectedElevator?.elevatorId,
    });

    final result = await gitIt.get<ApiService>().createIssue(issueModel);

    return result;
  }

  void reset() {
    selectedBuilding = null;
    selectedElevator = null;
    issueType = null;
    description = null;
  }
}
