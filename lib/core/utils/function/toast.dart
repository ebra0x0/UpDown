import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/material.dart';

void showToast(
    {required BuildContext context,
    required String message,
    required Icon icon}) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Row(
        spacing: 8,
        children: [
          icon,
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
