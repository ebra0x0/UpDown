import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/features/elevators/data/models/elevator_model.dart';
import 'package:UpDown/features/elevators/data/models/elevator_summary_model.dart';
import 'package:UpDown/features/elevators/data/models/unit_model.dart';
import 'package:either_dart/either.dart';

abstract class ElevatorRepo {
  Future<Either<Failure, ElevatorModel>> fetchElevatorDetails(
      String elevatorId);
  Future<Either<Failure, List<ElevatorSummaryModel>>> fetchElevatorsByBuilding(
      String buildingId);

  Future<Either<Failure, List<ElevatorSummaryModel>>> fetchElevatorsByBuildings(
      List<String> buildingIds);

  Future<Either<Failure, List<UnitModel>>> fetchElevatorUnits(
      String elevatorId);

  Future<Either<Failure, UnitModel>> fetchUnitDetails(String unitId);
}
