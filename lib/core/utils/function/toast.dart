import 'package:UpDown/core/utils/pallete.dart';
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
          Icon(
            type == ToastType.success
                ? Icons.check_circle_outline_rounded
                : Icons.error_outline_rounded,
            color: type == ToastType.success
                ? Pallete.lightSuccess
                : Pallete.lightError,
          ),
          Expanded(
            child: Text(
              message,
              style: Styles.textStyle14,
            ),
          )
        ],
      ),
    ),
  );
}
