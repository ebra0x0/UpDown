import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/model/drop_down_model.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.listItem,
    required this.hint,
    required this.value,
    this.error,
    this.prefixIcon,
    this.isLoading = false,
    this.onChanged,
  });
  final List<DropDownModel>? listItem;
  final String hint;
  final DropDownModel? value;
  final String? error;
  final Icon? prefixIcon;
  final bool isLoading;
  final void Function(Object? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<DropDownModel>(
      decoration: InputDecoration(
          errorBorder: Styles.errorBorder,
          enabledBorder: Styles.enabledBorder,
          border: Styles.generalBorder,
          focusedBorder: Styles.focusedBorder,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 4.sp, vertical: 4.sp),
          errorStyle: TextStyle(height: 0),
          prefixIcon: prefixIcon),
      hint: isLoading ? LoadingIndicator() : Text(hint),
      dropdownColor: AppTheme.accent,
      value: value,
      menuMaxHeight: 250,
      iconEnabledColor: AppTheme.primary,
      iconDisabledColor: AppTheme.accent,
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppTheme.primary,
        size: 24.sp,
      ),
      isDense: false,
      isExpanded: true,
      items: listItem == null
          ? []
          : listItem!.map((drop) {
              return DropdownMenuItem<DropDownModel>(
                value: drop,
                child: Text(drop.label,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
              );
            }).toList(),
      validator: (value) {
        if (value == null) {
          return error ?? "هذا الحقل مطلوب";
        }
        return null;
      },
      onChanged: (value) => onChanged == null ? null : onChanged!(value),
    );
  }
}
