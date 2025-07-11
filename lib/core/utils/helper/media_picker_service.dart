import 'dart:io';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/constants/regex.dart';
import 'package:image_picker/image_picker.dart';

class MediaPickerService {
  final ImagePicker _picker = ImagePicker();
  final RegExp _regexImage = Regex.kImageRegex;
  final RegExp _regexVideo = Regex.kVideoRegex;

  Future<(File?, MediaType?)> pickMedia() async {
    try {
      final XFile? media = await _picker.pickMedia();
      if (media == null) return (null, null);

      final file = File(media.path);

      if (_regexImage.hasMatch(media.path)) {
        return (file, MediaType.image);
      } else if (_regexVideo.hasMatch(media.path)) {
        return (file, MediaType.video);
      }
      return (null, null); // ملف غير مدعوم
    } catch (e) {
      return (null, null);
    }
  }
}
