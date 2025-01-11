import 'package:UpDown/core/widgets/custom_button.dart';
import 'package:UpDown/core/widgets/custom_text_form_field.dart';
import 'package:UpDown/features/auth/data/form_field_model.dart';
import 'package:UpDown/features/auth/validators/validator.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _FormKey = GlobalKey<FormState>();
  final FormFieldModel _emailField = FormFieldModel(
    labelText: " الإيميل",
    validator: Validator().emailValidator,
  );

  final FormFieldModel _passwordField = FormFieldModel(
    labelText: "كلمة المرور",
    isPassword: true,
    isSecure: true,
    validator: Validator().loginPasswordValidator,
  );

  void _submit() {
    if (_FormKey.currentState!.validate()) {
      _FormKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _FormKey,
      child: Column(
        children: [
          CustomTextFormField(
            keyType: TextInputType.emailAddress,
            labelText: "البريد الالكتروني",
            validator: _emailField.validator,
          ),
          SizedBox(height: 16),
          CustomTextFormField(
            keyType: TextInputType.visiblePassword,
            labelText: "كلمة المرور",
            validator: _passwordField.validator,
          ),
          SizedBox(height: 120),
          CustomButton(
            title: "تسجيل الدخول",
            onPress: _submit,
          ),
        ],
      ),
    );
  }
}
