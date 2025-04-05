import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/features/root/home/data/model/elevator_unit_model.dart';

class PanelModel extends ElevatorUnitModel {
  final String cardModel;

  PanelModel({
    required super.id,
    required super.status,
    required super.model,
    required super.name,
    required super.elevatorId,
    required super.createdAt,
    required super.updatedAt,
    required this.cardModel,
  });

  factory PanelModel.fromJson(Map<String, dynamic> json) {
    return PanelModel(
      id: json['id'],
      model: json['model'],
      status: UnitStatusExtension.fromString(json['status']),
      name: json['name'],
      elevatorId: json['elevator_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      cardModel: json['details']['card_model'],
    );
  }
}
