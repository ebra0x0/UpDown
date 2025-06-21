import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/elevators/data/models/cabin_model.dart';
import 'package:UpDown/features/elevators/data/models/engine_model.dart';
import 'package:UpDown/features/elevators/data/models/unit_model.dart';
import 'package:UpDown/features/elevators/data/models/wires_model.dart';

class UnitModelFactory {
  static UnitModel createUnitModel(Map<String, dynamic> json) {
    final String unitNameJsonString = json['name'] as String;
    final unitName = UnitName.values.firstWhere(
      (e) => e.name == unitNameJsonString,
      orElse: () => UnitName.engine,
    );

    switch (unitName) {
      case UnitName.cabin:
        return CabinModel.fromJson(json);
      case UnitName.engine:
        return EngineModel.fromJson(json);
      case UnitName.wires:
        return WiresModel.fromJson(json);
      case UnitName.counter:
        return UnitModel.fromJson(json);
      case UnitName.control:
        return UnitModel.fromJson(json);
    }
  }
}
