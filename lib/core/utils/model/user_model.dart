import 'package:UpDown/core/utils/model/building_model.dart';
import 'package:UpDown/core/utils/model/report_model.dart';

class UserModel {
  String id;
  String name;
  String? email;
  String? phone;
  String role;
  String passwordHash;
  DateTime createdAt;
  DateTime updatedAt;
  List<BuildingModel> buildings;
  List<ReportModel>? reports;

  UserModel({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    required this.role,
    required this.passwordHash,
    required this.createdAt,
    required this.updatedAt,
    required this.buildings,
    this.reports,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        role: json['role'],
        passwordHash: json['password_hash'],
        buildings: [],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'role': role,
        'password_hash': passwordHash,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'Buildings': buildings.map((building) => building.toJson()).toList(),
      };
}
