import 'dart:io';

class FileValidationException implements Exception {
  final String message;
  FileValidationException(this.message);

  @override
  String toString() => 'FileValidationException: $message';
}

class FileTooLargeException extends FileValidationException {
  FileTooLargeException(super.message);
}

class FileSizeValidator {
  static Future<bool> isFileSizeAcceptable({
    required String filePath,
    required int limitSizeMB,
  }) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw FileValidationException('الملف غير موجود: $filePath');
    }

    final fileSizeMB = (await file.length()) / (1024 * 1024);
    if (fileSizeMB > limitSizeMB) {
      throw FileTooLargeException('حجم الملف كبير');
    }
    return true;
  }
}
