import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection(
      {super.key,
      required this.title,
      this.actionText,
      this.onActionTap,
      this.titleStyle});

  final String title;
  final TextStyle? titleStyle;
  final String? actionText;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          Visibility(
              visible: actionText != null,
              child: TextButton(
                  onPressed: onActionTap, child: Text(actionText ?? "")))
        ],
      ),
    );
  }
}
