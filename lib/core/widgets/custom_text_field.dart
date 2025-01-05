import 'package:UpDown/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.keyType,
    required this.labelText,
    this.controller,
    this.onChanged,
  });

  final String labelText;
  final TextInputType keyType;
  final TextEditingController? controller;
  final void Function(String?)? onChanged;

  String? textValidator({required String? value}) {
    if (value == null || value.isEmpty) {
      return "لا يمكن ان يكون الحقل فارغ";
    } else {
      return null;
    }
  }

  String? numValidator({required String? value}) {
    if (value == null || value.isEmpty) {
      return null;
    } else {
      final regex = RegExp(r'\d+');
      final matches = regex.allMatches(value).map((e) => e.group(0)).toList();

      if (matches.isEmpty) {
        return 'رقم الطابق غير صحيح';
      } else {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyType,
      controller: controller,
      onChanged: onChanged,
      validator: (value) {
        if (keyType == TextInputType.text) {
          return textValidator(value: value);
        } else {
          return numValidator(value: value);
        }
      },
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: kprimaryTxtColor),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: kprimaryColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
