import 'dart:io';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/normalization.dart';
import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/custom_animated_button.dart';
import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MediaSelectorBox extends StatefulWidget {
  const MediaSelectorBox({
    super.key,
    required this.onMediaSelected,
  });
  final Function(File, MediaType) onMediaSelected;

  @override
  State<MediaSelectorBox> createState() => _MediaSelectorBoxState();
}

class _MediaSelectorBoxState extends State<MediaSelectorBox> {
  File? _image;
  File? _video;

  final RegExp _regexImage = Normalization.kImageRegex;
  final RegExp _regexVideo = Normalization.kVideoRegex;

  bool isLoading = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickMedia() async {
    setState(() {
      isLoading = true;
    });
    final XFile? media = await _picker.pickMedia();
    _image = null;
    _video = null;

    if (media != null) {
      if (_regexImage.hasMatch(media.path)) {
        setState(() {
          _image = File(media.path);
        });
        widget.onMediaSelected(_image!, MediaType.image);
      } else if (_regexVideo.hasMatch(media.path)) {
        setState(() {
          _video = File(media.path);
        });
        widget.onMediaSelected(_video!, MediaType.video);
      }
    }

    setState(() {
      isLoading = false;
    });
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
            child: isLoading
                ? LoadingIndicator()
                : _video != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            size: 32,
                            color: Pallete.lightSuccess,
                          ),
                          const Text(
                            'تم تحميل الفيديو',
                            style: Styles.textStyle14,
                          )
                        ],
                      )
                    : _image == null
                        ? Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 46,
                            color: Pallete.lightSecondary,
                          )
                        : null));
  }
}
