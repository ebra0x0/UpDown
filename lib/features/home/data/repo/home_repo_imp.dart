import 'package:UpDown/core/network/api_failure.dart';
import 'package:UpDown/features/buildings/data/repo/buildings_repo.dart';
import 'package:UpDown/features/buildings/data/models/building_summary_model.dart';
import 'package:UpDown/features/home/data/repo/home_repo.dart';
import 'package:UpDown/features/issues/data/models/issue_summary_response_model.dart';
import 'package:UpDown/features/issues/data/repo/issues_repo.dart';
import 'package:either_dart/either.dart';

class HomeRepoImp implements HomeRepo {
  HomeRepoImp(this._buildingsRepo, this._issuesRepo);
  final BuildingsRepo _buildingsRepo;
  final IssuesRepo _issuesRepo;

  @override
  Future<Either<Failure, List<BuildingSummaryModel>?>> fetchBuildings() async {
    return await _buildingsRepo.fetchBuildings();
  }

  @override
  Future<Either<Failure, List<IssueSummaryResponseModel>?>>
      fetchActiveIssues() async {
    return await _issuesRepo.fetchAllActiveIssues();
  }
}
