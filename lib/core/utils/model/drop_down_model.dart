class DropDownModel {
  final String label;
  final dynamic value;

  const DropDownModel({
    required this.label,
    required this.value,
  });

  DropDownModel copyWith({
    String? label,
    dynamic value,
  }) {
    return DropDownModel(
      label: label ?? this.label,
      value: value ?? this.value,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DropDownModel &&
        other.label == label &&
        other.value == value;
  }

  @override
  int get hashCode => Object.hash(label, value);
}
