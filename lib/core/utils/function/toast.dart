import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/styles.dart';
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
          type == ToastType.success ? Styles.checkIcon : Styles.errorIcon,
          Expanded(
            child: Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              message,
              style: Styles.textStyle14.copyWith(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      backgroundColor:
          type == ToastType.success ? AppTheme.green : AppTheme.red,
    ),
  );
}
