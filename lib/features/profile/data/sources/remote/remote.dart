import 'package:UpDown/core/network/api/api_service.dart';
import 'package:UpDown/features/profile/data/model/profile_request_model.dart';
import 'package:UpDown/features/profile/data/model/profile_response_model.dart';

class ProfileRemoteDataSource {
  final ApiService _apiService;

  ProfileRemoteDataSource(this._apiService);

  Stream<ProfileResponseModel?> get() {
    return _apiService.streamProfile().map((json) {
      if (json == null) {
        return null;
      }
      return ProfileResponseModel.fromJson(json);
    });
  }

  Future<void> update(ProfileRequestModel profile) async {
    return await _apiService.updateProfile(profile);
  }
}
