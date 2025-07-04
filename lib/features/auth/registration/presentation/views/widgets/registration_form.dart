import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/custom_text_form_field.dart';
import 'package:UpDown/core/widgets/password_field.dart';
import 'package:UpDown/core/utils/model/form_field_model.dart';
import 'package:UpDown/features/auth/manager/auth_cubit.dart';
import 'package:UpDown/features/auth/registration/presentation/views/widgets/registration_submit_builder.dart';
import 'package:UpDown/features/auth/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  final FormFieldModel _emailField = FormFieldModel(
    labelText: "الإيميل",
    validator: Validator().emailValidator,
  );

  final FormFieldModel _passwordField = FormFieldModel(
    labelText: "كلمة المرور",
    isPassword: true,
    isSecure: true,
    validator: Validator().regestrationPasswordValidator,
  );

  final FormFieldModel _rePasswordField = FormFieldModel(
    labelText: "تأكيد كلمة المرور",
    isPassword: true,
    isConfirmPassword: true,
    isSecure: true,
    validator: Validator().confirmPasswordValidator,
  );

  void _submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      FocusScope.of(context).unfocus();

      final String email = _emailField.controller.text.trim();
      final String pass = _passwordField.controller.text.trim();

      context.read<AuthCubit>().signUp(email: email, password: pass);
    } else {
      setState(() {
        _autoValidateMode = AutovalidateMode.always;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: _autoValidateMode,
      child: Column(
        spacing: 16,
        children: [
          CustomTextFormField(
            keyType: TextInputType.emailAddress,
            labelText: _emailField.labelText,
            controller: _emailField.controller,
            validator: _emailField.validator,
            prefixIcon: Styles.emailIcon,
          ),
          PasswordField(
            labelText: _passwordField.labelText,
            controller: _passwordField.controller,
            validator: _passwordField.validator,
            obscureText: _passwordField.isSecure,
            onChanged: (value) {
              setState(() {
                _rePasswordField.validator =
                    Validator(password: value).confirmPasswordValidator;
              });
            },
            toggleVisibility: () {
              setState(() {
                _passwordField.isSecure = !_passwordField.isSecure;
              });
            },
          ),
          PasswordField(
            labelText: _rePasswordField.labelText,
            controller: _rePasswordField.controller,
            validator: _rePasswordField.validator,
            obscureText: _rePasswordField.isSecure,
            toggleVisibility: () {
              setState(() {
                _rePasswordField.isSecure = !_rePasswordField.isSecure;
              });
            },
          ),
          SizedBox(height: 16),
          RegistrationSubmitSectionBuilder(submit: _submit),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailField.controller.dispose();
    _passwordField.controller.dispose();
    _rePasswordField.controller.dispose();
    super.dispose();
  }
}
