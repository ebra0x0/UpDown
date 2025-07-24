import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'profile_response_model.g.dart';
part 'profile_response_model.freezed.dart';

@freezed
@HiveType(typeId: 1)
class ProfileResponseModel with _$ProfileResponseModel {
  const factory ProfileResponseModel({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required String email,
    @HiveField(3) required String phone,
    @HiveField(4) required String address,
    @HiveField(5) @JsonKey(name: 'image_path') String? imagePath,
    @HiveField(6) @JsonKey(name: 'created_at') required DateTime createdAt,
    @HiveField(7) @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _ProfileResponseModel;

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseModelFromJson(json);

  factory ProfileResponseModel.empty() => ProfileResponseModel(
        id: '',
        name: 'User Name',
        phone: '01234567891',
        address: 'address',
        imagePath: '',
        email: 'example@example.com',
        createdAt: DateTime.now(),
        updatedAt: null,
      );
}
