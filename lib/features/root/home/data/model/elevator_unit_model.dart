import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/root/home/data/model/cabine_model.dart';
import 'package:UpDown/features/root/home/data/model/counter_model.dart';
import 'package:UpDown/features/root/home/data/model/engine_model.dart';
import 'package:UpDown/features/root/home/data/model/panel_model.dart';
import 'package:UpDown/features/root/home/data/model/wires_model.dart';

class ElevatorUnitModel {
  final String id;
  final UnitStatus status;
  final String? model;
  final String name;
  final String elevatorId;
  final DateTime createdAt;
  final DateTime updatedAt;

  ElevatorUnitModel({
    required this.id,
    required this.status,
    required this.model,
    required this.name,
    required this.elevatorId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ElevatorUnitModel.fromJson(Map<String, dynamic> json) {
    switch (json['name']) {
      case 'engine':
        return EngineModel.fromJson(json);
      case 'cabine':
        return CabineModel.fromJson(json);
      case 'counter':
        return CounterModel.fromJson(json);
      case 'wires':
        return WiresModel.fromJson(json);
      case 'panel':
        return PanelModel.fromJson(json);
      default:
        throw Exception('Unknown part type');
    }
  }
}
