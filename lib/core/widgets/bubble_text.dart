import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/theme/app_radius.dart';
import 'package:UpDown/core/theme/app_spacing.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BubbleText extends StatelessWidget {
  const BubbleText({
    super.key,
    required this.bubbleColor,
    required this.bubbleText,
  });

  final Color? bubbleColor;
  final String bubbleText;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding:
          AppInsets.h12.copyWith(top: AppSpacing.s4, bottom: AppSpacing.s4),
      decoration: BoxDecoration(
          color: bubbleColor?.withValues(alpha: 0.2) ??
              AppTheme.primaryColor.withValues(alpha: 0.2),
          borderRadius: AppRadius.borderRadius14),
      child: Text(
        bubbleText,
        textAlign: TextAlign.center,
        style: AppTextStyles.textStyle12.copyWith(
          color: bubbleColor ?? AppTheme.primaryColor,
        ),
      ),
    );
  }
}
