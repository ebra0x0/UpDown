import 'package:flutter/widgets.dart';

class FormFieldModel {
  final String? labelText;
  final TextEditingController controller;
  final bool isPassword;
  final bool isConfirmPassword;
  String? Function(String?)? validator;
  bool isSecure = false;

  FormFieldModel({
    this.labelText,
    bool? isPassword,
    this.isConfirmPassword = false,
    this.validator,
    this.isSecure = false,
  })  : isPassword = isPassword ?? false,
        controller = TextEditingController();
}
