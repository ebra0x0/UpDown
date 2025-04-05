import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/features/root/home/data/model/elevator_unit_model.dart';
import 'package:intl/intl.dart';

class WiresModel extends ElevatorUnitModel {
  final int count;
  // final WireStatus status;
  final DateTime lastChangeDate;

  WiresModel({
    required super.id,
    required super.status,
    required super.model,
    required super.name,
    required super.elevatorId,
    required super.createdAt,
    required super.updatedAt,
    required this.count,
    required this.lastChangeDate,
  });

  factory WiresModel.fromJson(Map<String, dynamic> json) {
    return WiresModel(
      id: json['id'],
      model: json['model'],
      status: UnitStatusExtension.fromString(json['status']),
      name: json['name'],
      elevatorId: json['elevator_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      count: json['details']['count'],
      lastChangeDate:
          DateFormat("yyyy-MM-dd").parse(json['details']['last_change_date']),
    );
  }
}
