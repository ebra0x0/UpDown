import 'package:UpDown/core/network/api_failure.dart';
import 'package:UpDown/core/network/api_service.dart';
import 'package:UpDown/features/profile/data/model/profile_request_model.dart';
import 'package:UpDown/features/account_setup/data/repos/account_setup_repo.dart';
import 'package:either_dart/either.dart';

class AccountSetupRepoImp implements AccountSetupRepo {
  final ApiService _api;
  AccountSetupRepoImp(this._api);
  @override
  Future<Either<Failure, void>> setup(ProfileRequestModel profile) async =>
      await _api.createProfile(profile);
}
