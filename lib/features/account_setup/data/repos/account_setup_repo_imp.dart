import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/core/utils/model/profile_model.dart';
import 'package:UpDown/features/account_setup/data/repos/account_setup_repo.dart';
import 'package:either_dart/either.dart';

class AccountSetupRepoImp implements AccountSetupRepo {
  final ApiService _api;
  AccountSetupRepoImp(this._api);
  @override
  Future<Either<Failure, void>> setup(ProfileModel profile) async {
    final res = await _api.createProfile(profile);
    return res.fold(
      (f) => Left(f),
      (_) => Right(null),
    );
  }
}
