import 'dart:io';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/extensions/ext_icon.dart';
import 'package:UpDown/core/utils/function/is_file_size_acceptable.dart';
import 'package:UpDown/features/issues/data/models/media_model.dart';
import 'package:flutter/material.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/normalization.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

part 'package:UpDown/core/widgets/media_selector_box.dart';

class MediaFormField extends FormField<File> {
  MediaFormField({
    super.key,
    required void Function(File file, MediaType type) onMediaSelected,
    required bool isLock,
    MediaModel? media,
    super.validator,
    super.initialValue,
    AutovalidateMode super.autovalidateMode = AutovalidateMode.disabled,
  }) : super(
          builder: (FormFieldState<File> field) {
            return _MediaSelectorBox(
              field: field,
              onMediaSelected: onMediaSelected,
              isDisabled: isLock,
              media: media,
            );
          },
        );
}
