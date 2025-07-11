import 'package:UpDown/core/network/api_failure.dart';
import 'package:UpDown/features/elevators/data/models/elevator_model.dart';
import 'package:UpDown/features/elevators/data/models/elevator_summary_response_model.dart';
import 'package:UpDown/features/elevators/data/models/unit_model.dart';
import 'package:either_dart/either.dart';

abstract class ElevatorsRepo {
  Future<Either<Failure, ElevatorModel>> fetchElevatorDetails(
      String elevatorId);
  Future<Either<Failure, List<ElevatorSummaryResponseModel>>>
      fetchElevatorsByBuilding(String buildingId);

  Future<Either<Failure, List<ElevatorSummaryResponseModel>>>
      fetchElevatorsByBuildings(List<String> buildingIds);

  Future<Either<Failure, List<UnitModel>>> fetchElevatorUnits(
      String elevatorId);

  Future<Either<Failure, UnitModel>> fetchUnitDetails(String unitId);
}
