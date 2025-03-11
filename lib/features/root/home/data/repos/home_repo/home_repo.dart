import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/features/root/home/data/model/building_summary_model.dart';
import 'package:either_dart/either.dart';

abstract class HomeRepo {
  List<BuildingSummaryModel>? cash;
  Future<Either<Failure, List<BuildingSummaryModel>>> fetchBuildingsSummary();
}
