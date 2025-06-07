import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      padding: EdgeInsets.symmetric(vertical: 12.sp),
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
