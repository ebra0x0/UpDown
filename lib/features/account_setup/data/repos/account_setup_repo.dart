import 'dart:developer';

import 'package:UpDown/core/network/api_failure.dart';
import 'package:UpDown/core/network/api_service.dart';
import 'package:UpDown/features/profile/data/model/profile_request_model.dart';
import 'package:either_dart/either.dart';

class AccountSetupRepo {
  final ApiService _api;
  AccountSetupRepo(this._api);

  Future<Either<Failure, void>> setup(ProfileRequestModel profile) async {
    try {
      await _api.createProfile(profile.copyWith(email: _api.user?.email));
      return Right(null);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      log(e.toString());
      return Left(CustomFailure((e as Failure).errMessage));
    }
  }
}
