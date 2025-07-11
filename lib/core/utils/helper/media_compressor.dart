import 'dart:io';

import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:video_compress/video_compress.dart';

Future<File?> prepareMediaFile(File file, MediaType type) async {
  File? resultFile;

  if (type == MediaType.image) {
    resultFile = await compressImage(file);
  } else if (type == MediaType.video) {
    // resultFile = await compressVideo(XFile(file.path));
  }

  if (resultFile != null && isUnder512KB(resultFile)) {
    return resultFile;
  } else {
    return null;
  }
}

bool isUnder512KB(File file) {
  final bytes = file.lengthSync();
  return bytes <= 512 * 1024;
}

Future<File?> compressImage(File file) async {
  final XFile? result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    '${file.parent.path}/${file.uri.pathSegments.last.replaceFirst(RegExp(r'\.[a-zA-Z]+$'), '_compressed.jpeg')}',
    quality: 60,
    format: CompressFormat.jpeg,
  );

  return result != null ? File(result.path) : null;
}

// Future<File?> compressVideo(XFile file) async {
//   try {
//     final MediaInfo? info = await VideoCompress.compressVideo(
//       file.path,
//       quality: VideoQuality.LowQuality,
//       deleteOrigin: false,
//     );
//     return info?.file;
//   } catch (e) {
//     return null;
//   }
// }
