import 'dart:io';
import 'package:flutter/material.dart';

class MediaValidator {
  static Future<bool> isFileSizeAcceptable({
    required File file,
    required int limitSizeMB,
    required BuildContext context,
  }) async {
    try {
      final sizeInBytes = await file.length();
      final sizeInMB = sizeInBytes / (1024 * 1024);
      if (sizeInMB > limitSizeMB) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("حجم الملف كبير")),
          );
        }
        return false;
      }
      return true;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ اثناء معالجة هذا الملف')),
        );
      }
      return false;
    }
  }
}
