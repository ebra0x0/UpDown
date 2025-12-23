import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/widgets/bubble_text.dart';

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
        BubbleText(bubbleColor: bubbleColor, bubbleText: bubbleText),
        Text(
          text,
          style: AppTextStyles.textStyle12.copyWith(
            color: AppTheme.greyColor,
          ),
        )
      ],
    );
  }
}
