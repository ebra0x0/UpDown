import 'package:UpDown/features/root/create_issue/data/model/report_model.dart';
import 'package:UpDown/features/root/home/data/model/building_summary_model.dart';
import 'package:UpDown/features/root/home/data/model/elevator_summary_model.dart';

class UserModel {
  String id;
  String name;
  String email;
  String phone;
  DateTime createdAt;
  DateTime updatedAt;
  List<BuildingSummaryModel> buildings;
  List<ElevatorSummaryModel> elevators;
  List<ReportModel>? reports;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    required this.buildings,
    required this.elevators,
    this.reports,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['user_id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        elevators: json['elevators'],
        reports: [],
        buildings: json['buildings'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'user_id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}
