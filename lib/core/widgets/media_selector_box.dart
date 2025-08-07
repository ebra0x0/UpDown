part of 'media_form_field.dart';

class _MediaSelectorBox extends StatefulWidget {
  const _MediaSelectorBox({
    required this.onMediaSelected,
    required this.field,
    this.isDisabled = false,
    this.media,
  });
  final FormFieldState<File> field;
  final Function(File, MediaType) onMediaSelected;
  final bool isDisabled;
  final MediaRequestModel? media;

  @override
  State<_MediaSelectorBox> createState() => _MediaSelectorBoxState();
}

class _MediaSelectorBoxState extends State<_MediaSelectorBox> {
  File? _image;
  File? _video;

  bool isLoading = false;
  final MediaPickerService _pickerService = MediaPickerService();

  @override
  void initState() {
    super.initState();
    if (widget.media?.file != null) {
      if (widget.media!.type == MediaType.image) {
        _image = widget.media!.file;
      } else {
        _video = widget.media!.file;
      }
    }
  }

  Future<void> pickMedia() async {
    if (isLoading || widget.isDisabled) return;

    setState(() {
      isLoading = true;
    });

    try {
      final (file, type) = await _pickerService.pickMedia();
      if (file == null || type == null) {
        setState(() {
          isLoading = false;
        });
        return;
      }

      setState(() {
        if (type == MediaType.image) {
          _image = file;
          _video = null;
        } else {
          _image = null;
          _video = file;
        }
        isLoading = false;
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
              borderRadius: AppRadius.borderRadius8,
              border: AppBorders.generalBoxBorder,
            ),
            child: isLoading
                ? LoadingIndicator(
                    size: 26.sp,
                  )
                : _video != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppIcons.checkIcon.copyWith(
                            size: 52.w,
                            color: AppTheme.green,
                          ),
                          Text(
                            'تم تحميل الفيديو',
                            style: AppTextStyles.textStyle14,
                          )
                        ],
                      )
                    : Visibility(
                        visible: _image == null,
                        child: AppIcons.addMediaIcon,
                      )));
  }
}
