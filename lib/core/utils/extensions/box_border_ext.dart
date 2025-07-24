import 'package:flutter/widgets.dart';

extension BoxBorderExtension on Border {
  Border copyWith({
    Color? color,
    double? width,
    BorderStyle? style,
  }) {
    return Border(
      top: top.copyWith(color: color, width: width, style: style),
      right: right.copyWith(color: color, width: width, style: style),
      bottom: bottom.copyWith(color: color, width: width, style: style),
      left: left.copyWith(color: color, width: width, style: style),
    );
  }
}
