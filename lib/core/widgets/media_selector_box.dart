part of 'media_form_field.dart';

class _MediaSelectorBox extends StatefulWidget {
  const _MediaSelectorBox({
    required this.onMediaSelected,
    required this.field,
  });
  final FormFieldState<File> field;
  final Function(File, MediaType) onMediaSelected;

  @override
  State<_MediaSelectorBox> createState() => _MediaSelectorBoxState();
}

class _MediaSelectorBoxState extends State<_MediaSelectorBox> {
  File? _image;
  File? _video;

  final RegExp _regexImage = Normalization.kImageRegex;
  final RegExp _regexVideo = Normalization.kVideoRegex;

  bool isLoading = false;

  final ImagePicker _picker = ImagePicker();

  // Future<void> pickMedia() async {
  //   if (isLoading) return;
  //   setState(() {
  //     isLoading = true;
  //   });
  //   final XFile? media = await _picker.pickMedia();

  //   if (media != null) {
  //     final File file = File(media.path);

  //     if (_regexImage.hasMatch(media.path)) {
  //       final bool isUnder5MB = await isFileSizeAcceptable(
  //           file: file, limitSize: 5, context: context);
  //       if (!isUnder5MB) {
  //         setState(() {
  //           isLoading = false;
  //         });
  //         return;
  //       }
  //       setState(() {
  //         _image = File(media.path);
  //       });
  //       widget.onMediaSelected(file, MediaType.image);
  //     } else if (_regexVideo.hasMatch(media.path)) {
  //       final bool isUnder20MB = await isFileSizeAcceptable(
  //           file: file, limitSize: 20, context: context);
  //       if (!isUnder20MB) {
  //         setState(() {
  //           isLoading = false;
  //           return;
  //         });
  //       }
  //       setState(() {
  //         _video = File(media.path);
  //       });
  //       widget.onMediaSelected(file, MediaType.video);
  //     }
  //     widget.field.didChange(file);
  //   }

  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  Future<void> pickMedia() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      final XFile? media = await _picker.pickMedia();

      if (media == null) return;

      final file = File(media.path);

      // تحديد النوع والحجم المطلوب
      late final MediaType type;
      late final int limitSizeMB;

      if (_regexImage.hasMatch(media.path)) {
        type = MediaType.image;
        limitSizeMB = 5;
      } else if (_regexVideo.hasMatch(media.path)) {
        type = MediaType.video;
        limitSizeMB = 20;
      } else {
        return; // ملف غير مدعوم
      }
      if (!context.mounted) return;

      final isAcceptable = await isFileSizeAcceptable(
        file: file,
        limitSize: limitSizeMB,
        // ignore: use_build_context_synchronously
        context: context,
      );

      if (!isAcceptable) return;

      setState(() {
        if (type == MediaType.image) {
          _image = file;
        } else {
          _video = file;
        }
      });

      widget.onMediaSelected(file, type);
      widget.field.didChange(file);
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: pickMedia,
        child: Container(
            width: double.infinity,
            height: 150.h,
            decoration: BoxDecoration(
              image: _image != null
                  ? DecorationImage(
                      image: Image.file(_image!).image, fit: BoxFit.cover)
                  : null,
              borderRadius: Styles.borderRadius8,
              border: Styles.generalBoxBorder,
            ),
            child: isLoading
                ? LoadingIndicator()
                : _video != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Styles.checkIcon.copyWith(
                            size: 52.w,
                            color: AppTheme.green,
                          ),
                          Text(
                            'تم تحميل الفيديو',
                            style: Styles.textStyle14,
                          )
                        ],
                      )
                    : Visibility(
                        visible: _image == null,
                        child: Styles.addMediaIcon,
                      )));
  }
}
