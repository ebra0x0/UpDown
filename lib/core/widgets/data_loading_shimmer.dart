import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/material.dart';

class DataLoadingIndicator extends StatelessWidget {
  const DataLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          minHeight: 100,
        ),
        decoration: BoxDecoration(
          borderRadius: Styles.borderRadius8,
          color: AppTheme.primary.withValues(alpha: 0.2),
        ),
      ),
    );
  }
}
