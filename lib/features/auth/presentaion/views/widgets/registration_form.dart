import 'package:UpDown/core/widgets/custom_button.dart';
import 'package:UpDown/core/widgets/custom_text_form_field.dart';
import 'package:UpDown/features/auth/data/auth_user_model.dart';
import 'package:UpDown/features/auth/data/form_field_model.dart';
import 'package:UpDown/features/auth/presentaion/manager/registration_cubit/registraion_cubit_state.dart';
import 'package:UpDown/features/auth/presentaion/manager/registration_cubit/registration_cubit.dart';
import 'package:UpDown/features/auth/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'password_field.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final GlobalKey<FormState> _registrationFormKey = GlobalKey<FormState>();

  final FormFieldModel _nameField = FormFieldModel(
    labelText: "الأسم",
    validator: Validator().nameValidator,
  );

  final FormFieldModel _emailField = FormFieldModel(
    labelText: "الإيميل",
    validator: Validator().emailValidator,
  );

  final FormFieldModel _passwordField = FormFieldModel(
    labelText: "كلمة المرور",
    isPassword: true,
    isSecure: true,
    validator: Validator().passwordValidator,
  );

  final FormFieldModel _rePasswordField = FormFieldModel(
    labelText: "تأكيد كلمة المرور",
    isPassword: true,
    isConfirmPassword: true,
    isSecure: true,
    validator: Validator().rePasswordValidator,
  );
  // final List<FormFieldModel> _fields = [
  //   FormFieldModel(labelText: "الأسم", validator: Validator().nameValidator),
  //   FormFieldModel(labelText: "الإيميل", validator: Validator().emailValidator),
  //   FormFieldModel(
  //       labelText: "كلمة المرور",
  //       isPassword: true,
  //       isSecure: true,
  //       validator: Validator().passwordValidator),
  //   FormFieldModel(
  //       labelText: "تأكيد كلمة المرور",
  //       isPassword: true,
  //       isConfirmPassword: true,
  //       isSecure: true,

  //       validator: Validator().rePasswordValidator),
  // ];

  @override
  void dispose() {
    _nameField.controller.dispose();
    _emailField.controller.dispose();
    _passwordField.controller.dispose();
    _rePasswordField.controller.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_registrationFormKey.currentState!.validate()) {
      _registrationFormKey.currentState!.save();
      final newUser = AuthUserModel(
        name: _nameField.controller.text,
        email: _emailField.controller.text,
        password: _passwordField.controller.text,
      );

      BlocProvider.of<RegistrationCubit>(context).signUp(newUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registrationFormKey,
      child: Column(
        spacing: 16,
        children: [
          CustomTextFormField(
            keyType: TextInputType.text,
            labelText: _nameField.labelText,
            controller: _nameField.controller,
            validator: _nameField.validator,
          ),
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
                    Validator(password: value).rePasswordValidator;
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
          SizedBox(height: 120),
          BlocBuilder<RegistrationCubit, RegistraionCubitState>(
              builder: (context, state) => CustomButton(
                    title: "إنشاء حساب ",
                    onPress: _signUp,
                    isLoading: state is RegistraionCubitLoading,
                  )),
        ],
      ),
    );
  }
}
