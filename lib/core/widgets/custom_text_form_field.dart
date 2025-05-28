import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/extensions/ext_icon.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
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
    this.maxLength,
    this.formKey,
  });
  final TextDirection? textDirection;
  final String? labelText;
  final String? hintText;
  final TextInputType? keyType;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final VoidCallback? toggleVisibility;
  final TextEditingController? controller;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final int maxLines;
  final int? maxLength;
  final GlobalKey<FormState>? formKey;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late FocusNode _focusNode;
  bool hasError = false;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          isFocused = true;
        });
      } else {
        setState(() {
          isFocused = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyType,
      focusNode: _focusNode,
      textDirection: widget.textDirection,
      textAlign: TextAlign.start,
      obscureText: widget.obscureText,
      maxLength: widget.maxLength,
      minLines: 1,
      maxLines: widget.maxLines,
      controller: widget.controller,
      onChanged: widget.onChanged,
      validator: (value) {
        final validatorResult = widget.validator!(value);
        if (validatorResult == null || validatorResult.isEmpty) {
          setState(() {
            hasError = false;
          });
          return null;
        }
        setState(() {
          hasError = true;
        });
        return validatorResult;
      },
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: Styles.textStyle14.copyWith(
          color: hasError
              ? AppTheme.red
              : isFocused
                  ? AppTheme.primary
                  : AppTheme.grey,
          backgroundColor: AppTheme.scaffold,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon?.copyWith(
          color: hasError
              ? AppTheme.red
              : isFocused
                  ? AppTheme.primary
                  : AppTheme.grey,
        ),
        suffixIcon: widget.suffixIcon,
        errorStyle: const TextStyle(height: 0),
        border: Styles.generalBorder,
        enabledBorder: Styles.enabledBorder,
        focusedBorder: Styles.focusedBorder,
        errorBorder: Styles.errorBorder,
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
