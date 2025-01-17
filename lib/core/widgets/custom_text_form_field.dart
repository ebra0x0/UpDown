import 'package:UpDown/core/utils/pallete.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.keyType,
    this.labelText,
    this.hintText,
    this.controller,
    this.onChanged,
    this.toggleVisibility,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
  });

  final String? labelText;
  final String? hintText;
  final TextInputType? keyType;
  final Widget? suffixIcon;
  final bool obscureText;
  final VoidCallback? toggleVisibility;
  final TextEditingController? controller;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyType,
      obscureText: obscureText,
      controller: controller,
      onChanged: onChanged,
      validator: (value) {
        return validator!(value);
      },
      decoration: InputDecoration(
          fillColor: Colors.grey.withValues(alpha: 0.1),
          filled: true,
          focusColor: Pallete.primary.withValues(alpha: 0.2),
          labelText: labelText,
          hintText: hintText,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Pallete.primary),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Pallete.error),
          )),
    );
  }
}
