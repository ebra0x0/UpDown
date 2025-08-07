import 'dart:io';
import 'package:UpDown/core/utils/helper/check_file_size.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:video_compress/video_compress.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

abstract class MediaCompressor {
  int get maxFileSizeMB;
  int get defaultQuality;

  Future<String> compress(String inputPath);

  Future<void> cleanUp(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      throw Exception('Failed to clean up file: $e');
    }
  }

  Future<String> generateOutputPath(String inputPath) async {
    final tempDir = await getTemporaryDirectory();
    final fileName = path.basenameWithoutExtension(inputPath);
    final extension = path.extension(inputPath);
    return '${tempDir.path}/${fileName}_compressed$extension';
  }

  Future<bool> isFileSizeValid(String inputPath) async {
    return await checkFileSize(inputPath, maxFileSizeMB);
  }
}

class ImageCompressorService extends MediaCompressor {
  static const int maxSizeMB = 10; // حجم الملف الحد الأقصى
  static const int quality = 70; // جودة الضغط (0-100)

  @override
  int get maxFileSizeMB => maxSizeMB;

  @override
  int get defaultQuality => quality;

  @override
  Future<String> compress(String inputPath) async {
    try {
      // فحص حجم الملف
      final isValidSize = await isFileSizeValid(inputPath);
      if (!isValidSize) {
        throw Exception('File is too large');
      }

      // إنشاء اسم ملف الإخراج
      final outputPath = await generateOutputPath(inputPath);

      final extension = path.extension(inputPath).toLowerCase();
      final supportedFormats = {
        '.jpg': CompressFormat.jpeg,
        '.jpeg': CompressFormat.jpeg,
        '.png': CompressFormat.png,
        '.webp': CompressFormat.webp,
      };

      // ضغط الصورة
      final XFile? result = await FlutterImageCompress.compressAndGetFile(
        inputPath,
        outputPath,
        quality: quality,
        format: supportedFormats[extension] ?? CompressFormat.jpeg,
      );

      if (result == null) {
        throw Exception('Failed to compress image');
      }

      return result.path;
    } catch (e) {
      throw Exception('Failed to compress image: $e');
    }
  }
}

class VideoCompressorService extends MediaCompressor {
  static const int maxSizeMB = 100;
  static const int quality = 23;

  @override
  int get maxFileSizeMB => maxSizeMB;

  @override
  int get defaultQuality => quality;

  @override
  Future<String> compress(String inputPath) async {
    try {
      // فحص حجم الملف
      final isValidSize = await isFileSizeValid(inputPath);
      if (!isValidSize) {
        throw Exception('File is too large');
      }

      // تنفيذ الضغط
      MediaInfo? mediaInfo = await VideoCompress.compressVideo(
        inputPath,
        includeAudio: true,
        quality: VideoQuality.LowQuality,
      );

      if (mediaInfo == null) {
        throw Exception('Failed to compress video');
      }
      final outputPath = await generateOutputPath(mediaInfo.path!);

      return outputPath;
    } catch (e) {
      throw Exception('Failed to compress video: $e');
    }
  }
}
