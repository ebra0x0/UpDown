import 'dart:io';
import 'package:UpDown/core/theme/app_borders.dart';
import 'package:UpDown/core/theme/app_icons.dart';
import 'package:UpDown/core/theme/app_radius.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/extensions/icon_ext.dart';
import 'package:UpDown/core/utils/helper/check_file_size.dart';
import 'package:UpDown/core/utils/helper/media_picker_service.dart';
import 'package:UpDown/core/utils/helper/toast.dart';
import 'package:UpDown/core/utils/models/media_models/media_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

part 'package:UpDown/core/widgets/media_selector_box.dart';

class MediaFormField extends FormField<File> {
  MediaFormField({
    super.key,
    required void Function(File file, MediaType type) onMediaSelected,
    required bool isLock,
    MediaRequestModel? media,
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
