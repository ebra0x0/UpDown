import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/elevators/data/models/units/cabin_model.dart';
import 'package:UpDown/features/elevators/data/models/units/control_model.dart';
import 'package:UpDown/features/elevators/data/models/units/counter_model.dart';
import 'package:UpDown/features/elevators/data/models/units/engine_model.dart';
import 'package:UpDown/features/elevators/data/models/units/wires_model.dart';

abstract class UnitModel {
  String get id;
  UnitStatus get status;
  UnitType get type;
  String get elevatorId;
  DateTime get createdAt;
  DateTime? get updatedAt;

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    final type = UnitType.values.firstWhere(
      (e) => e.name == json['type'],
      orElse: () =>
          throw UnimplementedError('Unknown unit type: ${json['type']}'),
    );

    switch (type) {
      case UnitType.engine:
        return EngineModel.fromJson(json);
      case UnitType.wires:
        return WiresModel.fromJson(json);
      case UnitType.cabin:
        return CabinModel.fromJson(json);
      case UnitType.counter:
        return CounterModel.fromJson(json);
      case UnitType.control:
        return ControlModel.fromJson(json);
    }
  }

  Map<String, dynamic> toJson() => throw UnimplementedError();

  factory UnitModel.empty() =>
      throw UnimplementedError('Must be implemented by subclasses');
}
