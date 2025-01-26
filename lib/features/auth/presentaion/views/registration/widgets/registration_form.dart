import 'package:UpDown/core/widgets/custom_button.dart';
import 'package:UpDown/core/widgets/custom_text_form_field.dart';
import 'package:UpDown/features/auth/data/model/auth_user_model.dart';
import 'package:UpDown/core/utils/model/form_field_model.dart';
import 'package:UpDown/features/auth/presentaion/manager/registration_cubit/registraion_cubit_state.dart';
import 'package:UpDown/features/auth/presentaion/manager/registration_cubit/registration_cubit.dart';
import 'package:UpDown/features/auth/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/widgets/password_field.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final GlobalKey<FormState> _registrationFormKey = GlobalKey<FormState>();
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

  @override
  void dispose() {
    _emailField.controller.dispose();
    _passwordField.controller.dispose();
    _rePasswordField.controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (_registrationFormKey.currentState!.validate()) {
      _registrationFormKey.currentState!.save();
      final newUser = AuthUserModel(
        email: _emailField.controller.text,
        password: _passwordField.controller.text,
      );

      BlocProvider.of<RegistrationCubit>(context).signUp(newUser);
    } else {
      setState(() {
        _autoValidateMode = AutovalidateMode.always;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registrationFormKey,
      autovalidateMode: _autoValidateMode,
      child: Column(
        spacing: 16,
        children: [
          CustomTextFormField(
            keyType: TextInputType.emailAddress,
            labelText: _emailField.labelText,
            controller: _emailField.controller,
            validator: _emailField.validator,
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
          BlocBuilder<RegistrationCubit, RegistraionCubitState>(
              builder: (context, state) {
            return Text(
              state is RegistraionCubitError ? state.error : "",
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            );
          }),
          SizedBox(height: 120),
          BlocBuilder<RegistrationCubit, RegistraionCubitState>(
              builder: (context, state) => CustomButton(
                    title: "إنشاء حساب ",
                    onPress: _submit,
                    isLoading: state is RegistraionCubitLoading,
                  )),
        ],
      ),
    );
  }
}
