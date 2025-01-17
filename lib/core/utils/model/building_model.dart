class BuildingModel {
  final int buildingId;
  final String name;
  final String address;
  final int ownerId;
  final DateTime createdAt;
  final DateTime updatedAt;

  BuildingModel({
    required this.buildingId,
    required this.name,
    required this.address,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BuildingModel.fromJson(Map<String, dynamic> json) {
    return BuildingModel(
      buildingId: json['BuildingID'],
      name: json['Name'],
      address: json['Address'],
      ownerId: json['OwnerID'],
      createdAt: DateTime.parse(json['CreatedAt']),
      updatedAt: DateTime.parse(json['UpdatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'BuildingID': buildingId,
      'Name': name,
      'Address': address,
      'OwnerID': ownerId,
      'CreatedAt': createdAt.toIso8601String(),
      'UpdatedAt': updatedAt.toIso8601String(),
    };
  }
}
