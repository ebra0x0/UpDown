import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {super.key,
      required this.child,
      this.padding = const EdgeInsets.all(16)});

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: Styles.borderRadius8),
      elevation: 5,
      shadowColor: AppTheme.shadow.withValues(
        alpha: .1,
      ),
      child: Padding(
        padding: padding,
        child: Center(child: child),
      ),
    );
  }
}
