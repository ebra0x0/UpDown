import 'package:UpDown/core/theme/app_theme.dart';
import 'package:flutter/widgets.dart';

class AppShadows {
  static final BoxShadow boxShadow = BoxShadow(
    color: AppTheme.shadowColor.withValues(alpha: 0.1),
    blurRadius: 10,
    offset: Offset(0, 2),
  );
}
