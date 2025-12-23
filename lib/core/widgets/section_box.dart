import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/theme/app_radius.dart';
import 'package:UpDown/core/theme/app_spacing.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SectionBox extends StatelessWidget {
  const SectionBox(
      {super.key,
      required this.children,
      this.borderRadius,
      this.color,
      this.spacing,
      this.padding,
      this.crossAxisAlignment});

  final List<Widget> children;
  final BorderRadius? borderRadius;
  final Color? color;
  final double? spacing;
  final EdgeInsets? padding;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? AppTheme.backgroundColor,
        borderRadius: borderRadius ?? AppRadius.borderRadius12,
      ),
      padding: padding ?? AppInsets.all16,
      child: children.length == 1
          ? SizedBox(width: double.infinity, child: children.first)
          : Column(
              spacing: spacing ?? AppSpacing.s4,
              crossAxisAlignment:
                  crossAxisAlignment ?? CrossAxisAlignment.start,
              children: children,
            ),
    );
  }
}
