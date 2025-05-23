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

  Future<void> pickMedia() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });
    final XFile? media = await _picker.pickMedia();
    _image = null;
    _video = null;

    if (media != null) {
      final File file = File(media.path);

      if (_regexImage.hasMatch(media.path)) {
        setState(() {
          _image = File(media.path);
        });
        widget.onMediaSelected(file, MediaType.image);
      } else if (_regexVideo.hasMatch(media.path)) {
        setState(() {
          _video = File(media.path);
        });
        widget.onMediaSelected(file, MediaType.video);
      }
      widget.field.didChange(file);
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
            width: double.infinity,
            height: 150.h,
            decoration: BoxDecoration(
              image: _image != null
                  ? DecorationImage(
                      image: Image.file(_image!).image, fit: BoxFit.cover)
                  : null,
              color: AppTheme.accent,
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
                            size: 32.w,
                          ),
                          Text(
                            'تم تحميل الفيديو',
                            style: Styles.textStyle14,
                          )
                        ],
                      )
                    : Visibility(
                        visible: _image == null, child: Styles.addPhotoIcon)));
  }
}
