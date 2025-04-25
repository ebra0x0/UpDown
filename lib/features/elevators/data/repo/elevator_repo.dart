import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/features/elevators/data/models/elevator_model.dart';
import 'package:UpDown/features/elevators/data/models/elevator_summary_model.dart';
import 'package:either_dart/either.dart';

abstract class ElevatorRepo {
  Future<Either<Failure, ElevatorModel?>> fetchElevatorDetails(
      String elevatorId);
  Future<Either<Failure, List<ElevatorSummaryModel>?>> fetchElevators(
      String buildingId);
}
