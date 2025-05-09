class ProfileModel {
  final String id;
  final String name;
  final String phone;
  final String address;
  final String? imagePath;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String role = "client";

  ProfileModel({
    required this.name,
    required this.phone,
    required this.address,
    this.imagePath,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["user_id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        email: json["email"],
        imagePath: json["image_path"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson({bool isRemote = false}) {
    final Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "phone": phone,
      "address": address,
      "image_path": imagePath,
      "email": email,
    };
    if (!isRemote) {
      data["user_id"] = id;
      data["created_at"] = createdAt.toIso8601String();
      data["updated_at"] = updatedAt.toIso8601String();
    }
    return data;
  }
}
