import 'dart:convert';
import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/core/utils/model/profile_model.dart';
import 'package:UpDown/core/utils/secure_storage.dart';
import 'package:UpDown/core/utils/service_locator.dart';
import 'package:UpDown/features/profile/data/repos/profile_repo.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ProfileRepoImp implements ProfileRepo {
  final ApiService _apiService;

  ProfileRepoImp(this._apiService);
  @override
  Future<Either<Failure, ProfileModel?>> call() async {
    final localData = await _fetchLocalData();
    if (localData != null) {
      return Right(localData);
    }
    return await _fetchRemoteData();
  }

  Future<ProfileModel?> _fetchLocalData() async {
    final storedUser = await gitIt.get<SecureStorage>().get("user_data");
    if (storedUser != null) {
      return ProfileModel.fromJson(jsonDecode(storedUser));
    }
    return null;
  }

  Future<Either<Failure, ProfileModel?>> _fetchRemoteData() async {
    final response = await _apiService.fetchProfile();
    if (response.isRight) {
      gitIt.get<SecureStorage>().addAll({
        "user_data": jsonEncode(response.right!.toJson()),
      });
    }
    return response;
  }

  @override
  Future<Either<Failure, void>> updateAvatar(XFile file) async {
    return await _apiService.uploadAvatar(file);
  }
}
