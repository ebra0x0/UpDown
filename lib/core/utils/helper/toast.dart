import 'package:UpDown/core/theme/app_icons.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/theme/app_theme.dart';

import 'package:flutter/material.dart';

enum ToastType { success, error }

void showToast(
    {required BuildContext context,
    required String message,
    required ToastType type}) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Row(
        spacing: 8,
        children: [
          type == ToastType.success ? AppIcons.checkIcon : AppIcons.errorIcon,
          Expanded(
            child: Text(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              message,
              style: AppTextStyles.textStyle14.copyWith(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      backgroundColor:
          type == ToastType.success ? AppTheme.greenColor : AppTheme.redColor,
    ),
  );
}
