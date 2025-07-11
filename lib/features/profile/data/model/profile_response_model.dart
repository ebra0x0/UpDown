import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'profile_response_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(createToJson: false)
class ProfileResponseModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String phone;
  @HiveField(4)
  final String address;
  @HiveField(5)
  @JsonKey(name: 'image_path')
  final String? imagePath;
  @HiveField(6)
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @HiveField(7)
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  const ProfileResponseModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.imagePath,
    required this.createdAt,
    this.updatedAt,
  });

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
