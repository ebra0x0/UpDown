import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/features/root/home/data/model/elevator_unit_model.dart';
import 'package:intl/intl.dart';

class CounterModel extends ElevatorUnitModel {
  final int chairsCount;
  final int weightsCount;
  final DateTime lastOiledDate;

  CounterModel({
    required super.id,
    required super.model,
    required super.status,
    required super.name,
    required super.elevatorId,
    required super.createdAt,
    required super.updatedAt,
    required this.chairsCount,
    required this.weightsCount,
    required this.lastOiledDate,
  });

  factory CounterModel.fromJson(Map<String, dynamic> json) {
    return CounterModel(
      id: json['id'],
      model: json['model'],
      status: UnitStatusExtension.fromString(json['status']),
      name: json['name'],
      elevatorId: json['elevator_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      chairsCount: json['details']['chairs_count'],
      weightsCount: json['details']['weights_count'],
      lastOiledDate:
          DateFormat('yyyy-MM-dd').parse(json['details']['last_oiled_date']),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'status': status,
        'model': model,
        'name': name,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'chairs_count': chairsCount,
        'weights_count': weightsCount,
        'last_oiled_date': lastOiledDate.toIso8601String(),
      };
}
