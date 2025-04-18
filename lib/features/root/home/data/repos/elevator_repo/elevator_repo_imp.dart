import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/features/root/home/data/model/elevator_model.dart';
import 'package:UpDown/features/root/home/data/repos/elevator_repo/elevator_repo.dart';
import 'package:either_dart/either.dart';

class ElevatorRepoImp implements ElevatorRepo {
  final ApiService _api;

  ElevatorRepoImp(this._api);
  @override
  ElevatorModel? cash;

  @override
  Future<Either<Failure, ElevatorModel>> fetchElevatorDetails(
      {required String elevatorId}) async {
    if (cash != null) {
      return Right(cash!);
    }
    final result = await _api.fetchElevatorDetails(elevatorId: elevatorId);

    result.fold(
      (errMsg) => errMsg,
      (response) => response,
    );

    if (result.isLeft) {
      return Left(result.left);
    }

    cash = result.right;
    return Right(result.right);
  }
}
