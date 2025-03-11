import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/features/root/home/data/model/building_model.dart';
import 'package:either_dart/either.dart';

abstract class BuildingRepo {
  BuildingModel? cash;
  Future<Either<Failure, BuildingModel>> fetchBuildingDetails(
      {required String buildingId});
}
