import 'dart:io';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AvatarPicker extends StatefulWidget {
  final ValueChanged<XFile>? onImageSelected;
  final String? image;
  const AvatarPicker({
    super.key,
    this.onImageSelected,
    this.image,
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
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    _isPicking = false;

    setState(() {
      _image = pickedFile != null ? XFile(pickedFile.path) : null;
    });

    if (_image != null && widget.onImageSelected != null) {
      widget.onImageSelected!(_image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String? imagePath = _image?.path ?? widget.image;
    return Center(
      child: GestureDetector(
          onTap: _pickImage,
          child: CircleAvatar(
            radius: 76.h,
            backgroundColor: AppTheme.background,
            backgroundImage:
                imagePath != null ? Image.file(File(imagePath)).image : null,
            child: imagePath == null ? Styles.cameraIcon : null,
          )),
    );
  }
}
