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
    final media = widget.media;
    if (media != null && media.file != null && media.file!.existsSync()) {
      if (media.type == MediaType.image) {
        _image = media.file;
      } else if (media.type == MediaType.video) {
        _video = media.file;
      }
    }
  }

  Future<void> pickMedia() async {
    if (isLoading || widget.isDisabled) return;

    setState(() {
      isLoading = true;
    });

    try {
      final (files, type) = await _pickerService.pickMedia(
        selectionType: MediaSelectionType.singleImage,
        source: ImageSource.gallery,
      );

      if (files.isEmpty || type == null) {
        return;
      }

      setState(() {
        if (type == MediaType.image) {
          _image = files.first;
          _video = null;
        } else {
          _image = null;
          _video = files.first;
        }
      });

      widget.onMediaSelected(files.first, type);
      widget.field.didChange(files.first);
    } on FileTooLargeException catch (e) {
      if (mounted) {
        showToast(context: context, message: e.message, type: ToastType.error);
      }
    } on UnsupportedFileTypeException catch (e) {
      if (mounted) {
        showToast(context: context, message: e.message, type: ToastType.error);
      }
    } catch (e) {
      if (mounted) {
        showToast(
            context: context,
            message: 'لم يتم اختيار صورة صالحة',
            type: ToastType.error);
      }
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
      onTap: isLoading || widget.isDisabled ? null : pickMedia,
      child: Container(
        width: double.infinity,
        height: 150.h,
        decoration: BoxDecoration(
          image: _image != null && _image!.existsSync()
              ? DecorationImage(
                  fit: BoxFit.contain,
                  image: Image.file(
                    _image!,
                    fit: BoxFit.contain,
                    width: 300.w,
                    height: 150.h,
                  ).image,
                )
              : null,
          borderRadius: AppRadius.borderRadius8,
          border: AppBorders.generalBoxBorder,
        ),
        child: isLoading
            ? LoadingIndicator(
                size: 26.sp,
              )
            : _video != null && _video!.existsSync()
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
                      ),
                    ],
                  )
                : Visibility(
                    visible: _image == null && _video == null,
                    child: AppIcons.addMediaIcon,
                  ),
      ),
    );
  }
}
