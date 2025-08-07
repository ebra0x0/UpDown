import 'dart:io';

Future<bool> checkFileSize(String inputPath, int maxFileSizeMB) async {
  final file = File(inputPath);
  if (!await file.exists()) {
    throw Exception('File does not exist');
  }
  final fileSizeMB = (await file.length()) / (1024 * 1024);
  return fileSizeMB <= maxFileSizeMB;
}
