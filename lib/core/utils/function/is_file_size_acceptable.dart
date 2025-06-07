import 'dart:io';

import 'package:UpDown/core/utils/function/toast.dart';
import 'package:flutter/widgets.dart';

Future<bool> isFileSizeAcceptable(
    {required File file,
    required int limitSize,
    required BuildContext context}) async {
  int sizeInBytes = await file.length();
  final int maxSizeInBytes = limitSize * 1024 * 1024;

  if (sizeInBytes > maxSizeInBytes) {
    showToast(
        context: context,
        message: "الملف حجمه كبير جداً",
        type: ToastType.error);
    return false;
  }
  return true;
}
