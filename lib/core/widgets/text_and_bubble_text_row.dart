import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/theme/app_radius.dart';
import 'package:UpDown/core/theme/app_spacing.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/theme/app_theme.dart';

import 'package:flutter/widgets.dart';

class TextAndbubbleTextRow extends StatelessWidget {
  const TextAndbubbleTextRow({
    super.key,
    required this.text,
    required this.bubbleText,
    this.bubbleColor,
  });

  final String text;
  final String bubbleText;
  final Color? bubbleColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Container(
          alignment: Alignment.center,
          padding:
              AppInsets.h12.copyWith(top: AppSpacing.s4, bottom: AppSpacing.s4),
          decoration: BoxDecoration(
              color: bubbleColor?.withValues(alpha: 0.2) ??
                  AppTheme.primary.withValues(alpha: 0.2),
              borderRadius: AppRadius.borderRadius14),
          child: Text(
            bubbleText,
            textAlign: TextAlign.center,
            style: AppTextStyles.textStyle12.copyWith(
              color: bubbleColor ?? AppTheme.primary,
            ),
          ),
        ),
        Text(
          text,
          style: AppTextStyles.textStyle12.copyWith(
            color: AppTheme.grey,
          ),
        )
      ],
    );
  }
}
