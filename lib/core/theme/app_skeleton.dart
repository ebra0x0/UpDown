import 'package:UpDown/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppSkeletonizer extends StatelessWidget {
  final bool enabled;
  final Widget child;
  final bool isSliver;
  final bool ignorePointer;
  final bool ignoreContainers;

  const AppSkeletonizer({
    super.key,
    required this.enabled,
    required this.child,
    this.isSliver = false,
    this.ignorePointer = true,
    this.ignoreContainers = false,
  });

  @override
  Widget build(BuildContext context) {
    final ShimmerEffect effect = ShimmerEffect(
      baseColor: AppTheme.surfaceColor,
      highlightColor: AppTheme.primaryColor.withValues(alpha: 0.1),
      duration: Duration(milliseconds: 1000),
    );

    if (isSliver) {
      return Skeletonizer.sliver(
        enabled: enabled,
        effect: effect,
        containersColor: AppTheme.backgroundColor,
        ignoreContainers: ignoreContainers,
        ignorePointers: ignorePointer,
        child: child,
      );
    }
    return Skeletonizer(
      enabled: enabled,
      effect: effect,
      containersColor: AppTheme.backgroundColor,
      ignoreContainers: ignoreContainers,
      ignorePointers: ignorePointer,
      child: child,
    );
  }
}
