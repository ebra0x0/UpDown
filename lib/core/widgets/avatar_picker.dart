import 'dart:io';
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

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedFile != null ? XFile(pickedFile.path) : null;
    });

    if (_image != null && widget.onImageSelected != null) {
      widget.onImageSelected!(_image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          onTap: _pickImage,
          child: CircleAvatar(
            radius: 76.h,
            backgroundImage: _image != null
                ? Image.file(File(_image!.path)).image
                : widget.image != null
                    ? Image.file(File(widget.image!)).image
                    : null,
            child:
                _image == null && widget.image == null ? Styles.addIcon : null,
          )),
    );
  }
}
