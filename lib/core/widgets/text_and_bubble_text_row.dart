import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/styles.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
              color: bubbleColor?.withValues(alpha: 0.2) ??
                  AppTheme.primary.withValues(alpha: 0.2),
              borderRadius: Styles.borderRadius14),
          child: Text(
            bubbleText,
            textAlign: TextAlign.center,
            style: Styles.textStyle12.copyWith(
              color: bubbleColor ?? AppTheme.primary,
            ),
          ),
        ),
        Text(
          text,
          style: Styles.textStyle12.copyWith(
            color: AppTheme.grey,
          ),
        )
      ],
    );
  }
}
