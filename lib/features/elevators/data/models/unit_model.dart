import 'package:UpDown/core/utils/enums/enums.dart';

class UnitModel {
  final String id;
  final String elevatorId;
  final String name;
  final UnitStatus status;
  final String? model;
  final String createdAt;
  final String? updatedAt;

  UnitModel({
    required this.id,
    required this.status,
    required this.model,
    required this.name,
    required this.elevatorId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'],
      status: UnitStatus.values
          .firstWhere((element) => element.name == json['status']),
      model: json['model'],
      name: json['name'],
      elevatorId: json['elevator_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  factory UnitModel.empty() {
    return UnitModel(
      id: '',
      status: UnitStatus.active,
      model: '',
      name: 'engine',
      elevatorId: '',
      createdAt: '',
      updatedAt: '',
    );
  }
}
