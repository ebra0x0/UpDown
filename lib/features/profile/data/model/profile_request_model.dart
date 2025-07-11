import 'package:json_annotation/json_annotation.dart';
part 'profile_request_model.g.dart';

@JsonSerializable(createFactory: false)
class ProfileRequestModel {
  final String name;
  final String? email;
  final String address;
  final String phone;
  @JsonKey(name: 'image_path')
  final String? imagePath;

  const ProfileRequestModel({
    required this.name,
    this.email,
    required this.address,
    required this.phone,
    this.imagePath,
  });

  Map<String, dynamic> toJson() => _$ProfileRequestModelToJson(this);

  ProfileRequestModel copyWith({
    String? name,
    String? email,
    String? address,
    String? phone,
    String? imagePath,
  }) {
    return ProfileRequestModel(
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
