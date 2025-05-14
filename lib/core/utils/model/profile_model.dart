class ProfileModel {
  final String id;
  final String name;
  final String phone;
  final String address;
  final String? imagePath;
  final String? email;
  final DateTime createdAt;
  final DateTime? updatedAt;

  ProfileModel({
    required this.name,
    required this.phone,
    required this.address,
    this.imagePath,
    this.email,
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
      data["created_at"] = createdAt.toIso8601String();
      data["updated_at"] = updatedAt?.toIso8601String();
    }
    return data;
  }
}
