import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:UpDown/features/buildings/data/models/building_summary_model.dart';
import 'package:UpDown/features/buildings/data/repo/buildings_repo.dart';
import 'package:either_dart/either.dart';

class BuildingsRepoImp implements BuildingsRepo {
  BuildingsRepoImp(this._api);
  final ApiService _api;

  @override
  Future<Either<Failure, BuildingModel>> fetchBuildingDetails(
      String buildingId) async {
    final result = await _api.fetchBuildingDetails(buildingId: buildingId);

    return result;
  }

  @override
  Future<Either<Failure, List<BuildingSummaryModel>>> fetchBuildings() async {
    final result = await _api.fetchBuildings();

    return result;
  }
}
