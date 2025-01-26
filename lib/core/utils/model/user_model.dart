import 'package:UpDown/features/home/data/model/building_model.dart';
import 'package:UpDown/features/create_report/data/model/report_model.dart';

class UserModel {
  String id;
  String name;
  String? email;
  String? phone;
  String role;
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
        buildings: [],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'role': role,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'Buildings': buildings.map((building) => building.toJson()).toList(),
      };
}
