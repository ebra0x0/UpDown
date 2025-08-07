import 'dart:developer';
import 'dart:io';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/constants/regex.dart';
import 'package:UpDown/core/utils/helper/check_file_size.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class MediaPickerService {
  final ImagePicker _picker = ImagePicker();
  final RegExp _regexImage = Regex.kImageRegex;
  final RegExp _regexVideo = Regex.kVideoRegex;

  Future<(File?, MediaType?)> pickMedia() async {
    try {
      final XFile? media = await _picker.pickMedia();
      if (media == null) return (null, null);

      log('Picked file path: ${media.path}');

      final mimeType = lookupMimeType(media.path);
      if (mimeType == null) {
        log('Unable to determine MIME type');
        return (null, null);
      }

      if (mimeType.startsWith('image/') && _regexImage.hasMatch(media.path)) {
        final isFileSizeValid =
            await checkFileSize(media.path, 10); // 10MB limit
        if (!isFileSizeValid) {
          log('Image size exceeds 10MB');
          return (null, null);
        }

        return (File(media.path), MediaType.image);
      }

      if (mimeType.startsWith('video/') && _regexVideo.hasMatch(media.path)) {
        final isFileSizeValid =
            await checkFileSize(media.path, 50); // 50MB limit
        if (!isFileSizeValid) {
          log('Video size exceeds 50MB');
          return (null, null);
        }

        return (File(media.path), MediaType.video);
      }

      log('Unsupported media type: $mimeType');
      return (null, null);
    } catch (e, stack) {
      log('Error while picking media: $e\n$stack');
      return (null, null);
    }
  }
}
