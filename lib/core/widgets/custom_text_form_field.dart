import 'package:UpDown/core/utils/pallete.dart';
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
    this.validator,
    this.maxLines = 1,
    this.formKey,
  });
  final TextDirection? textDirection;
  final String? labelText;
  final String? hintText;
  final TextInputType? keyType;
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
          fillColor: Pallete.containerLight,
          filled: true,
          labelText: labelText,
          hintText: hintText,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: Styles.borderRadius8,
            borderSide: const BorderSide(color: Pallete.secondary, width: .4),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: Styles.borderRadius8,
            borderSide: const BorderSide(color: Pallete.secondary, width: .4),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: Styles.borderRadius8,
            borderSide: const BorderSide(color: Pallete.primary),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: Styles.borderRadius8,
            borderSide: const BorderSide(color: Pallete.error),
          )),
    );
  }

  TextDirection getTextDirection(String text) {
    final bool isEnglish = RegExp(r'^[a-zA-Z]').hasMatch(text);

    return isEnglish ? TextDirection.ltr : TextDirection.rtl;
  }
}
