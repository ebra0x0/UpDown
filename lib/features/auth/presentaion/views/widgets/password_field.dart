import 'package:UpDown/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final String? labelText;
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback toggleVisibility;
  final String? Function(String?)? validator;
  final ValueChanged<String?>? onChanged;

  const PasswordField({
    this.labelText,
    required this.controller,
    required this.obscureText,
    required this.toggleVisibility,
    this.validator,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      labelText: labelText,
      toggleVisibility: toggleVisibility,
      obscureText: obscureText,
      suffixIcon: IconButton(
        icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
        onPressed: toggleVisibility,
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
