import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/features/root/home/data/model/elevator_model.dart';
import 'package:either_dart/either.dart';

abstract class ElevatorRepo {
  ElevatorModel? cash;
  Future<Either<Failure, ElevatorModel>> fetchElevatorDetails(
      {required String elevatorId});
}
