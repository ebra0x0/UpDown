import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/localization/local_service.dart';
import 'package:UpDown/features/elevators/data/models/cabine_model.dart';
import 'package:UpDown/features/elevators/data/models/counter_model.dart';
import 'package:UpDown/features/elevators/data/models/engine_model.dart';
import 'package:UpDown/features/elevators/data/models/control_model.dart';
import 'package:UpDown/features/elevators/data/models/wires_model.dart';
import 'package:intl/intl.dart';

class ElevatorUnitModel {
  final String id;
  final UnitStatus status;
  final String? model;
  final String name;
  final String elevatorId;
  final String createdAt;
  final String updatedAt;

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
    final DateTime? createdAt = DateTime.tryParse(json['created_at']);
    final DateTime? updatedAt = DateTime.tryParse(json['updated_at']);
    final String locale = LocaleService.currentLocale;

    final UnitName unitName =
        UnitNameExtension.fromString(json['name'] as String);

    json['created_at'] = createdAt == null
        ? ''
        : DateFormat('d MMMM, hh:mm a', locale).format(createdAt);
    json['updated_at'] = updatedAt == null
        ? ''
        : DateFormat('d MMMM, hh:mm a', locale).format(updatedAt);

    switch (unitName) {
      case UnitName.engine:
        return EngineModel.fromJson(json);
      case UnitName.cabine:
        return CabineModel.fromJson(json);
      case UnitName.counter:
        return CounterModel.fromJson(json);
      case UnitName.wires:
        return WiresModel.fromJson(json);
      case UnitName.control:
        return ControlModel.fromJson(json);
    }
  }
}
