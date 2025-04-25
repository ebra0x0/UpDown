import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/features/elevators/data/models/elevator_model.dart';
import 'package:UpDown/features/elevators/data/models/elevator_summary_model.dart';
import 'package:UpDown/features/elevators/data/repo/elevator_repo.dart';
import 'package:either_dart/either.dart';

class ElevatorRepoImp implements ElevatorRepo {
  final ApiService _api;

  ElevatorRepoImp(this._api);

  @override
  Future<Either<Failure, ElevatorModel?>> fetchElevatorDetails(
      String elevatorId) async {
    final result = await _api.fetchElevatorDetails(elevatorId: elevatorId);

    return result.fold(
      (errMsg) => Left(errMsg),
      (response) => Right(response),
    );
  }

  @override
  Future<Either<Failure, List<ElevatorSummaryModel>?>> fetchElevators(
      String buildingId) async {
    final result = await _api.fetchElevators(buildingId: buildingId);

    return result.fold(
      (errMsg) => Left(errMsg),
      (response) => Right(response),
    );
  }
}
