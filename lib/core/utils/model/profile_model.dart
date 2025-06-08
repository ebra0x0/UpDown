import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'profile_model.g.dart';

@HiveType(typeId: 1)
class ProfileModel extends Equatable {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String phone;

  @HiveField(3)
  final String address;

  @HiveField(4)
  final String? imagePath;

  @HiveField(5)
  final String? email;

  @HiveField(6)
  final DateTime? createdAt;

  @HiveField(7)
  final DateTime? updatedAt;

  const ProfileModel({
    this.id,
    required this.name,
    required this.phone,
    required this.address,
    this.imagePath,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["user_id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        email: json["email"],
        imagePath: json["image_path"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  copyWith({
    String? id,
    String? name,
    String? phone,
    String? address,
    String? imagePath,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      imagePath: imagePath ?? this.imagePath,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson({bool isRemote = false}) {
    final Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
      "image_path": imagePath,
    };
    if (!isRemote) {
      data["user_id"] = id;
      data["created_at"] = createdAt?.toIso8601String();
      data["updated_at"] = updatedAt?.toIso8601String();
    }
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        address,
        imagePath,
        email,
        createdAt,
        updatedAt,
      ];
}
