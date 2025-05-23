import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.keyType,
    this.textDirection,
    this.labelText,
    this.hintText,
    this.controller,
    this.onChanged,
    this.toggleVisibility,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.maxLines = 1,
    this.formKey,
  });
  final TextDirection? textDirection;
  final String? labelText;
  final String? hintText;
  final TextInputType? keyType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final VoidCallback? toggleVisibility;
  final TextEditingController? controller;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final int maxLines;
  final GlobalKey<FormState>? formKey;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyType,
      textDirection: textDirection,
      textAlign: TextAlign.start,
      obscureText: obscureText,
      minLines: 1,
      maxLines: maxLines,
      controller: controller,
      onChanged: onChanged,
      validator: (value) {
        return validator!(value);
      },
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: Styles.textStyle14.copyWith(
          color: AppTheme.grey,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorStyle: const TextStyle(height: 0),
        border: Styles.generalBorder,
        enabledBorder: Styles.enabledBorder,
        focusedBorder: Styles.focusedBorder,
        errorBorder: Styles.errorBorder,
      ),
    );
  }
}
