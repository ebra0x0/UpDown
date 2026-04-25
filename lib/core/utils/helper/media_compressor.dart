import 'dart:developer';
import 'dart:io';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/helper/check_file_size.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:video_compress/video_compress.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class MediaCompressionException implements Exception {
  final String message;
  MediaCompressionException(this.message);

  @override
  String toString() => 'MediaCompressionException: $message';
}

abstract class MediaCompressor {
  int get maxFileSizeMB;
  int get defaultQuality;

  Future<String> compress(String inputPath, {int? quality});

  Future<void> cleanUp(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      throw MediaCompressionException('فشل في تنظيف الملف: $e');
    }
  }

  Future<String> generateOutputPath(String inputPath) async {
    final tempDir = await getTemporaryDirectory();
    final fileName = path.basenameWithoutExtension(inputPath);
    final extension = path.extension(inputPath);
    return '${tempDir.path}/${fileName}_compressed${DateTime.now().millisecondsSinceEpoch}$extension';
  }

  Future<bool> isFileSizeValid({
    required String filePath,
    required MediaType mediaType,
  }) async =>
      await FileSizeValidator.isFileSizeAcceptable(
        filePath: filePath,
        limitSizeMB: maxFileSizeMB,
      );
}

class ImageCompressorService extends MediaCompressor {
  static const int _maxSizeMB = 10;
  static const int _defaultQuality = 50;
  static const _supportedFormats = {
    '.jpg': CompressFormat.jpeg,
    '.jpeg': CompressFormat.jpeg,
    '.png': CompressFormat.png,
    '.webp': CompressFormat.webp,
  };

  @override
  int get maxFileSizeMB => _maxSizeMB;

  @override
  int get defaultQuality => _defaultQuality;

  @override
  Future<String> compress(String inputPath, {int? quality}) async {
    try {
      // التحقق من الامتداد
      final extension = path.extension(inputPath).toLowerCase();
      if (!_supportedFormats.containsKey(extension)) {
        throw MediaCompressionException('امتداد الصورة غير مدعوم: $extension');
      }

      // فحص حجم الملف
      final isValidSize = await isFileSizeValid(
        filePath: inputPath,
        mediaType: MediaType.image,
      );
      log('Before compression - Output file size: ${await File(inputPath).length()} bytes');
      if (!isValidSize) {
        throw MediaCompressionException('حجم الصورة كبير جدًا');
      }

      // إنشاء مسار الإخراج
      CompressFormat targetFormat = _supportedFormats[extension]!;
      String targetExtension = extension;

      // إذا كانت الصورة PNG، نحولها إلى WEBP لتقليل الحجم مع الحفاظ على الشفافية
      if (targetFormat == CompressFormat.png) {
        targetFormat = CompressFormat.webp;
        targetExtension = '.webp';
      }

      // إنشاء مسار الإخراج الأساسي
      String outputPath = await generateOutputPath(inputPath);

      // التأكد من أن مسار الإخراج ينتهي بالامتداد الصحيح (خاصة لو تم تحويله لـ WEBP)
      if (path.extension(outputPath).toLowerCase() != targetExtension) {
        // نقوم بحذف الامتداد القديم وإضافة الامتداد الجديد
        outputPath = path.withoutExtension(outputPath) + targetExtension;
      }

      // ضغط الصورة
      final XFile? result = await FlutterImageCompress.compressAndGetFile(
        inputPath,
        outputPath,
        quality: quality ?? defaultQuality,
        minWidth: 1080,
        minHeight: 1080,
        // format: _supportedFormats[extension]!,
        format: targetFormat,
      );

      if (result == null) {
        throw MediaCompressionException('فشل في ضغط الصورة');
      }

      // التحقق من حجم الملف بعد الضغط
      final isOutputValid = await isFileSizeValid(
        filePath: result.path,
        mediaType: MediaType.image,
      );
      log('Output file size: ${await File(result.path).length()} bytes');
      if (!isOutputValid) {
        await cleanUp(result.path);
        throw MediaCompressionException('حجم الصورة المضغوطة كبير جدًا');
      }

      return result.path;
    } catch (e) {
      throw MediaCompressionException('فشل في ضغط الصورة: $e');
    }
  }
}

class VideoCompressorService extends MediaCompressor {
  static const int _maxSizeMB = 100;
  static const int _defaultQuality = 23;
  static const _supportedFormats = ['.mp4', '.mov', '.avi'];

  @override
  int get maxFileSizeMB => _maxSizeMB;

  @override
  int get defaultQuality => _defaultQuality;

  @override
  Future<String> compress(String inputPath, {int? quality}) async {
    try {
      // التحقق من الامتداد
      final extension = path.extension(inputPath).toLowerCase();
      if (!_supportedFormats.contains(extension)) {
        throw MediaCompressionException('امتداد الفيديو غير مدعوم: $extension');
      }

      // فحص حجم الملف
      final isValidSize = await isFileSizeValid(
        filePath: inputPath,
        mediaType: MediaType.video,
      );
      if (!isValidSize) {
        throw MediaCompressionException('حجم الفيديو كبير جدًا');
      }

      // تنفيذ الضغط
      final mediaInfo = await VideoCompress.compressVideo(
        inputPath,
        includeAudio: true,
        quality:
            quality != null ? _mapQuality(quality) : VideoQuality.LowQuality,
      );

      if (mediaInfo == null || mediaInfo.path == null) {
        throw MediaCompressionException('فشل في ضغط الفيديو');
      }

      // التحقق من حجم الملف بعد الضغط
      final isOutputValid = await isFileSizeValid(
        filePath: mediaInfo.path!,
        mediaType: MediaType.video,
      );
      if (!isOutputValid) {
        await cleanUp(mediaInfo.path!);
        throw MediaCompressionException('حجم الفيديو المضغوط كبير جدًا');
      }

      return mediaInfo.path!;
    } catch (e) {
      throw MediaCompressionException('فشل في ضغط الفيديو: $e');
    }
  }

  VideoQuality _mapQuality(int quality) {
    if (quality <= 33) return VideoQuality.LowQuality;
    if (quality <= 66) return VideoQuality.MediumQuality;
    return VideoQuality.HighestQuality;
  }
}
