import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.child, this.padding = 16.0});

  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: Styles.borderRadius8),
      elevation: 5,
      shadowColor: AppTheme.scaffold.withValues(
        alpha: 0.4,
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Center(child: child),
      ),
    );
  }
}
