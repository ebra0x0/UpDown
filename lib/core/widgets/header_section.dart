import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/utils/extensions/icon_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection(
      {super.key,
      required this.title,
      this.actionText,
      this.onActionTap,
      this.titleStyle,
      this.titleIcon});

  final String title;
  final Icon? titleIcon;
  final TextStyle? titleStyle;
  final String? actionText;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.sp,
      padding: AppInsets.v2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (titleIcon != null)
                titleIcon!.copyWith(color: titleStyle?.color),
              const SizedBox(width: 8),
              Text(
                title,
                style: titleStyle,
              ),
            ],
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
