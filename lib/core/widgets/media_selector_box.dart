import 'dart:io';
import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/custom_animated_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MediaSelectorBox extends StatefulWidget {
  const MediaSelectorBox({
    super.key,
  });

  @override
  State<MediaSelectorBox> createState() => _MediaSelectorBoxState();
}

class _MediaSelectorBoxState extends State<MediaSelectorBox> {
  File? _image;
  File? _video;
  final RegExp _regexImage = RegExp(
      r'^[^\s]+\/[\w\-.]+\.(jpg|jpeg|png|gif|bmp|webp|tiff|ico)$',
      caseSensitive: false);
  final RegExp _regexVideo = RegExp(
      r'^[^\s]+\/[\w\-.]+\.(mp4|mkv|mov|avi|wmv|flv|webm|mpeg|mpg|m4v)$',
      caseSensitive: false);

  final ImagePicker _picker = ImagePicker();

  Future<void> pickMedia() async {
    final XFile? media = await _picker.pickMedia();
    _image = null;
    _video = null;
    if (media != null) {
      if (_regexImage.hasMatch(media.path)) {
        setState(() {
          _image = File(media.path);
        });
      } else if (_regexVideo.hasMatch(media.path)) {
        setState(() {
          _video = File(media.path);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedButton(
        action: pickMedia,
        child: Container(
          width: 125,
          height: 125,
          decoration: BoxDecoration(
            image: _image != null
                ? DecorationImage(
                    image: Image.file(_image!).image, fit: BoxFit.cover)
                : null,
            color: Pallete.lightCard,
            borderRadius: Styles.borderRadius8,
            boxShadow: [Styles.boxShadow],
          ),
          child: _video != null
              ? Center(
                  child: Text(
                  "تم تأكيد الفيديو",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ))
              : Icon(
                  Icons.add_photo_alternate_outlined,
                  size: 46,
                  color: Pallete.lightSecondary,
                ),
        ));
  }
}
