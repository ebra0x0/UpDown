import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:UpDown/features/buildings/data/models/building_summary_model.dart';
import 'package:either_dart/either.dart';

abstract class BuildingsRepo {
  Future<Either<Failure, BuildingModel?>> fetchBuildingDetails(
      String buildingId);

  Future<Either<Failure, List<BuildingSummaryModel>?>> fetchBuildings();
}
