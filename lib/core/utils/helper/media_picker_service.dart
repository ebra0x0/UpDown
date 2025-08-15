import 'dart:developer';
import 'dart:io';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/helper/check_file_size.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;

class MediaPickerException implements Exception {
  final String message;
  MediaPickerException(this.message);

  @override
  String toString() => 'MediaPickerException: $message';
}

class UnsupportedFileTypeException implements Exception {
  final String message;
  UnsupportedFileTypeException(this.message);

  @override
  String toString() => 'UnsupportedFileTypeException: $message';
}

enum MediaSelectionType {
  singleImage,
  multipleImages,
  video,
}

class MediaConfig {
  static const sizeLimits = {
    MediaType.image: 10,
    MediaType.video: 100,
    MediaType.other: 50,
  };

  static const supportedExtensions = {
    MediaType.image: ['jpg', 'jpeg', 'png', 'webp'],
    MediaType.video: ['mp4', 'mov', 'avi'],
  };

  static const supportedMimeTypes = {
    MediaType.image: ['image/jpeg', 'image/png', 'image/webp'],
    MediaType.video: ['video/mp4', 'video/quicktime', 'video/x-msvideo'],
  };
}

class MediaPickerService {
  final ImagePicker _picker = ImagePicker();

  Future<(List<File>, MediaType?)> pickMedia({
    required MediaSelectionType selectionType,
    ImageSource source = ImageSource.gallery,
  }) async {
    try {
      switch (selectionType) {
        case MediaSelectionType.singleImage:
          return await _pickSingleImage(source);
        case MediaSelectionType.multipleImages:
          return await _pickMultipleImages(source);
        case MediaSelectionType.video:
          return await _pickVideo(source);
      }
    } on FileValidationException catch (_) {
      rethrow;
    } catch (e) {
      log('خطأ أثناء اختيار الوسائط: $e');
      throw MediaPickerException('فشل في اختيار الوسائط: $e');
    }
  }

  Future<(List<File>, MediaType?)> _pickSingleImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);

    if (image == null) {
      log('لم يتم اختيار صورة');
      return (<File>[], null);
    }

    log('تم اختيار صورة: ${image.path}');

    final (file, mediaType) =
        await _validateMedia(image, expectedType: MediaType.image);
    return file == null ? (<File>[], null) : ([file], mediaType);
  }

  Future<(List<File>, MediaType?)> _pickMultipleImages(
      ImageSource source) async {
    final List<XFile> images = await _picker.pickMultiImage();

    if (images.isEmpty) {
      log('لم يتم اختيار صور');
      return (<File>[], null);
    }

    log('تم اختيار ${images.length} صورة');

    final List<File> validFiles = [];
    for (final image in images) {
      final (file, mediaType) =
          await _validateMedia(image, expectedType: MediaType.image);
      if (file != null && mediaType == MediaType.image) {
        validFiles.add(file);
      } else {
        log('تم تجاهل صورة غير صالحة: ${image.path}');
      }
    }

    if (validFiles.isEmpty) {
      log('لم يتم العثور على صور صالحة');
      return (<File>[], null);
    }

    return (validFiles, MediaType.image);
  }

  Future<(List<File>, MediaType?)> _pickVideo(ImageSource source) async {
    final XFile? video = await _picker.pickVideo(source: source);

    if (video == null) {
      log('لم يتم اختيار فيديو');
      return (<File>[], null);
    }

    log('تم اختيار فيديو: ${video.path}');

    final (file, mediaType) =
        await _validateMedia(video, expectedType: MediaType.video);
    if (file == null || mediaType == null) {
      return (<File>[], null);
    }

    return ([file], mediaType);
  }

  Future<(File?, MediaType?)> _validateMedia(XFile media,
      {required MediaType expectedType}) async {
    // التحقق من امتداد الملف
    final extension =
        path.extension(media.path).toLowerCase().replaceFirst('.', '');

    if (!MediaConfig.supportedExtensions[expectedType]!.contains(extension)) {
      log('امتداد الملف غير مدعوم: $extension');
      throw UnsupportedFileTypeException('نوع الملف غير مدعوم: $extension');
    }

    // التحقق من نوع MIME
    final mimeType = lookupMimeType(media.path);
    if (mimeType == null ||
        !mimeType.startsWith('${expectedType.toString().split('.').last}/')) {
      log('نوع MIME غير متطابق: $mimeType');
      throw UnsupportedFileTypeException('نوع الملف غير صالح: $mimeType');
    }

    // التحقق من حجم الملف
    await FileSizeValidator.isFileSizeAcceptable(
      filePath: media.path,
      limitSizeMB: MediaConfig.sizeLimits[expectedType]!,
    );

    return (File(media.path), expectedType);
  }
}
