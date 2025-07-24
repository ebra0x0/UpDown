import 'package:UpDown/core/network/api_failure.dart';
import 'package:UpDown/core/network/api_service.dart';
import 'package:UpDown/features/elevators/data/models/elevator_model.dart';
import 'package:UpDown/features/elevators/data/models/elevator_summary_response_model.dart';
import 'package:UpDown/features/elevators/data/models/unit_model.dart';
import 'package:UpDown/features/elevators/data/repo/elevators_repo.dart';
import 'package:either_dart/either.dart';

class ElevatorsRepoImp implements ElevatorsRepo {
  final ApiService _api;

  ElevatorsRepoImp(this._api);

  @override
  Future<Either<Failure, ElevatorModel>> fetchElevatorDetails(
      String elevatorId) async {
    try {
      final res = await _api.fetchElevatorDetails(elevatorId: elevatorId);
      return Right(res);
    } catch (e) {
      return Left(CustomFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ElevatorSummaryResponseModel>>>
      fetchElevatorsByBuilding(String buildingId) async {
    try {
      final res = await _api.fetchElevatorsByBuilding(buildingId: buildingId);
      return Right(res);
    } catch (e) {
      return Left(CustomFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ElevatorSummaryResponseModel>>>
      fetchElevatorsByBuildings(List<String> buildingIds) async {
    try {
      final res =
          await _api.fetchElevatorsByBuildings(buildingIds: buildingIds);
      return Right(res);
    } catch (e) {
      return Left(CustomFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UnitModel>>> fetchElevatorUnits(
      String elevatorId) async {
    try {
      final res = await _api.fetchElevatorUnits(elevatorId: elevatorId);
      return Right(res);
    } catch (e) {
      return Left(CustomFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UnitModel>> fetchUnitDetails(String unitId) async {
    try {
      final res = await _api.fetchUnitDetails(unitId: unitId);
      return Right(res);
    } catch (e) {
      return Left(CustomFailure(e.toString()));
    }
  }
}
