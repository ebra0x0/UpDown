import 'package:flutter/widgets.dart';

extension IconCopyWith on Icon {
  Icon copyWith({
    IconData? icon,
    Color? color,
    double? size,
    String? semanticLabel,
    TextDirection? textDirection,
    List<Shadow>? shadows,
  }) {
    return Icon(
      icon ?? this.icon,
      color: color ?? this.color,
      size: size ?? this.size,
      semanticLabel: semanticLabel ?? this.semanticLabel,
      textDirection: textDirection ?? this.textDirection,
      shadows: shadows ?? this.shadows,
    );
  }
}
