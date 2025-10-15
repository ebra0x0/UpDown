import 'package:UpDown/core/storage/hive/hive_type_ids.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'technician_model.freezed.dart';
part 'technician_model.g.dart';

@HiveType(typeId: HiveTypeIds.technicianModel)
@Freezed(toJson: false)
class TechnicianModel with _$TechnicianModel {
  factory TechnicianModel({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) String? phone,
    @HiveField(3) String? email,
    @HiveField(4) String? image,
    @HiveField(5) @JsonKey(name: 'created_at') required DateTime createdAt,
    @HiveField(6) @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _TechnicianModel;

  factory TechnicianModel.fromJson(Map<String, Object?> json) =>
      _$TechnicianModelFromJson(json);

  factory TechnicianModel.empty() => TechnicianModel(
        id: '',
        name: 'اسم الفني',
        phone: 'رقم الهاتف',
        email: 'البريد الإلكتروني',
        image: null,
        createdAt: DateTime(2021, 1, 1),
        updatedAt: null,
      );
}
