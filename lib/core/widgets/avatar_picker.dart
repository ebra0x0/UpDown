import 'dart:io';
import 'package:UpDown/core/utils/helper/check_file_size.dart';
import 'package:UpDown/core/utils/helper/toast.dart';
import 'package:flutter/material.dart';
import 'package:UpDown/core/theme/app_icons.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/helper/media_picker_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AvatarPicker extends StatefulWidget {
  final ValueChanged<File>? onImageSelected;
  final String? image;
  final bool isLoading;
  final ImageSource source;

  const AvatarPicker({
    super.key,
    this.onImageSelected,
    this.image,
    this.isLoading = false,
    this.source = ImageSource.gallery,
  });

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  File? _image;
  final MediaPickerService _picker = MediaPickerService();
  bool _isPicking = false;

  Future<void> _pickImage() async {
    if (_isPicking) return;
    _isPicking = true;

    try {
      final (files, mediaType) = await _picker.pickMedia(
        selectionType: MediaSelectionType.singleImage,
        source: widget.source,
      );

      if (files.isEmpty || mediaType != MediaType.image) {
        _isPicking = false;
        return;
      }

      setState(() {
        _image = files.first;
      });

      if (widget.onImageSelected != null) {
        widget.onImageSelected!(_image!);
      }
    } on UnsupportedFileTypeException catch (_) {
      if (mounted) {
        showToast(
            context: context, message: 'ملف غير مدعوم', type: ToastType.error);
      }
    } on FileTooLargeException catch (_) {
      if (mounted) {
        showToast(
            context: context,
            message: 'حجم الصورة كبير',
            type: ToastType.error);
      }
    } catch (_) {
      if (mounted) {
        showToast(
            context: context,
            message: 'فشل في أختيار الملف',
            type: ToastType.error);
      }
    } finally {
      _isPicking = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String? imagePath = _image?.path ?? widget.image;
    File? imageFile;
    if (imagePath != null) {
      imageFile = File(imagePath);
      if (!imageFile.existsSync()) {
        imageFile = null;
      }
    }

    return Center(
      child: GestureDetector(
        onTap: _isPicking || widget.isLoading ? null : _pickImage,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 76.h,
              backgroundColor: AppTheme.backgroundColor,
              backgroundImage: imageFile != null
                  ? Image.file(
                      imageFile,
                      fit: BoxFit.cover,
                      width: 152.h,
                      height: 152.h,
                    ).image
                  : null,
              child: imageFile == null ? AppIcons.cameraIcon : null,
            ),
            if (widget.isLoading)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(76.h),
                  child: Container(
                    color: AppTheme.blackColor.withValues(alpha: 0.7),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
