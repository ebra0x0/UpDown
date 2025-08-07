import 'dart:io';
import 'package:UpDown/core/theme/app_icons.dart';
import 'package:UpDown/core/theme/app_theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AvatarPicker extends StatefulWidget {
  final ValueChanged<XFile>? onImageSelected;
  final String? image;
  final bool isLoading;
  const AvatarPicker({
    super.key,
    this.onImageSelected,
    this.image,
    this.isLoading = false,
  });

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isPicking = false;

  Future<void> _pickImage() async {
    if (_isPicking) return;
    _isPicking = true;
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    _isPicking = false;

    if (pickedFile == null) return;

    setState(() {
      _image = pickedFile;
    });
    widget.onImageSelected!(pickedFile);
  }

  @override
  Widget build(BuildContext context) {
    final String? imagePath = _image?.path ?? widget.image;
    return Center(
        child: GestureDetector(
      onTap: _pickImage,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 76.h,
            backgroundColor: AppTheme.background,
            backgroundImage:
                imagePath != null ? Image.file(File(imagePath)).image : null,
            child: imagePath == null ? AppIcons.cameraIcon : null,
          ),
          if (widget.isLoading)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(76.h),
                child: Container(
                  color: AppTheme.black.withValues(alpha: 0.7),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
        ],
      ),
    ));
  }
}
