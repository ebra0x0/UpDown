import 'dart:io';

import 'package:UpDown/core/utils/pallete.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarPicker extends StatefulWidget {
  final ValueChanged<XFile>? onImageSelected;

  const AvatarPicker({
    super.key,
    this.onImageSelected,
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
    return GestureDetector(
      onTap: _pickImage,
      child: _image != null
          ? CircleAvatar(
              radius: 48,
              backgroundImage: Image.file(File(_image!.path)).image,
            )
          : const CircleAvatar(
              radius: 48,
              backgroundColor: Pallete.lightPrimary,
              child: Icon(Icons.person, size: 48, color: Pallete.lightCard),
            ),
    );
  }
}
