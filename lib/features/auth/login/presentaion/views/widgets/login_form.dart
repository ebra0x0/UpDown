import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/custom_text_form_field.dart';
import 'package:UpDown/core/utils/model/form_field_model.dart';
import 'package:UpDown/core/widgets/password_field.dart';
import 'package:UpDown/features/auth/login/presentaion/views/widgets/sign_up_link_text.dart';
import 'package:UpDown/features/auth/manager/auth_cubit.dart';
import 'package:UpDown/features/auth/login/presentaion/views/widgets/login_submit_section_builder.dart';
import 'package:UpDown/features/auth/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  final FormFieldModel _emailField = FormFieldModel(
    labelText: "الإيميل",
    validator: Validator().emailValidator,
  );

  final FormFieldModel _passwordField = FormFieldModel(
    labelText: "كلمة المرور",
    isPassword: true,
    isSecure: true,
    validator: Validator().loginPasswordValidator,
  );

  void _submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      FocusScope.of(context).unfocus();
      final String email = _emailField.controller.text.trim();
      final String pass = _passwordField.controller.text.trim();

      context.read<AuthCubit>().signIn(email: email, password: pass);
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
        children: [
          CustomTextFormField(
            formKey: formKey,
            keyType: TextInputType.emailAddress,
            labelText: "البريد الالكتروني",
            controller: _emailField.controller,
            validator: _emailField.validator,
            prefixIcon: Styles.emailIcon,
          ),
          SizedBox(height: 16),
          PasswordField(
            labelText: "كلمة المرور",
            controller: _passwordField.controller,
            validator: _passwordField.validator,
            obscureText: _passwordField.isSecure,
            toggleVisibility: () {
              setState(() {
                _passwordField.isSecure = !_passwordField.isSecure;
              });
            },
          ),
          const SizedBox(height: 16),
          SignUpLinkText(),
          SizedBox(
            height: 46,
          ),
          LoginSubmitSectionBuilder(
            submit: _submit,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailField.controller.dispose();
    _passwordField.controller.dispose();
    super.dispose();
  }
}
