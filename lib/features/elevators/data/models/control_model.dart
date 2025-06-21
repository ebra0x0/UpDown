import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/features/elevators/data/models/unit_model.dart';

class ControlModel extends UnitModel {
  final String cardModel;

  ControlModel({
    required super.id,
    required super.status,
    required super.model,
    required super.name,
    required super.elevatorId,
    required super.createdAt,
    required super.updatedAt,
    required this.cardModel,
  });

  factory ControlModel.fromJson(Map<String, dynamic> json) {
    return ControlModel(
      id: json['id'],
      model: json['model'],
      status: UnitStatusExtension.fromString(json['status']),
      name: json['name'],
      elevatorId: json['elevator_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      cardModel: json['details']['card_model'],
    );
  }
}
