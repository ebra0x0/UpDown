import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/theme/app_radius.dart';
import 'package:UpDown/core/theme/app_theme.dart';

import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: AppRadius.borderRadius8),
      elevation: 5,
      shadowColor: AppTheme.shadow.withValues(
        alpha: .1,
      ),
      child: Padding(
        padding: padding ?? AppInsets.all16,
        child: Center(child: child),
      ),
    );
  }
}
