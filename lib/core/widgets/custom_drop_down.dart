import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/extensions/ex_icon.dart';
import 'package:UpDown/core/utils/model/drop_down_model.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({
    super.key,
    required this.listItem,
    required this.hint,
    required this.value,
    this.error,
    this.prefixIcon,
    this.isLoading = false,
    this.isEnabled = true,
    this.onChanged,
  });
  final List<DropDownModel> listItem;
  final String hint;
  final DropDownModel? value;
  final String? error;
  final Icon? prefixIcon;
  final bool isLoading;
  final void Function(Object? value)? onChanged;
  final bool isEnabled;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  bool hasError = false;

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
          prefixIcon: widget.prefixIcon?.copyWith(
            color: hasError
                ? AppTheme.red
                : widget.listItem.isEmpty
                    ? AppTheme.grey.withValues(
                        alpha: 0.5,
                      )
                    : AppTheme.grey,
            size: 24.sp,
          )),
      hint: widget.isLoading
          ? LoadingIndicator(
              size: 18.sp,
            )
          : Text(
              widget.hint,
              style: Styles.textStyle14.copyWith(
                color: hasError ? AppTheme.red : AppTheme.grey,
              ),
            ),
      dropdownColor: AppTheme.background,
      value: widget.value,
      menuMaxHeight: 250,
      iconEnabledColor: AppTheme.grey,
      iconDisabledColor: AppTheme.grey.withValues(
        alpha: 0.5,
      ),
      icon: Icon(
        Icons.arrow_drop_down_rounded,
        size: 32.sp,
        color: hasError ? AppTheme.red : null,
      ),
      isDense: false,
      isExpanded: true,
      items: widget.listItem.map((drop) {
        return DropdownMenuItem<DropDownModel>(
          enabled: widget.isEnabled,
          value: drop,
          child: Text(drop.label, maxLines: 1, overflow: TextOverflow.ellipsis),
        );
      }).toList(),
      validator: (value) {
        if (value == null || value.label.isEmpty) {
          setState(() {
            hasError = true;
          });
          return widget.error ?? "هذا الحقل مطلوب";
        }
        setState(() {
          hasError = false;
        });
        return null;
      },
      onChanged: (value) =>
          widget.onChanged == null ? null : widget.onChanged!(value),
    );
  }
}
