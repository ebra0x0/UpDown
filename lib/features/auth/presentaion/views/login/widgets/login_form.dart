import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/utils/manager/auth_cubit/cubit/auth_cubit.dart';
import 'package:UpDown/core/widgets/custom_button.dart';
import 'package:UpDown/core/widgets/custom_text_form_field.dart';
import 'package:UpDown/core/widgets/password_field.dart';
import 'package:UpDown/features/auth/data/model/auth_user_model.dart';
import 'package:UpDown/core/utils/model/form_field_model.dart';
import 'package:UpDown/features/auth/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  TextDirection? _emailTextDirection;
  TextDirection? _passTextDirection;

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

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

  @override
  void dispose() {
    _emailField.controller.dispose();
    _passwordField.controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      FocusScope.of(context).unfocus();
      final AuthUserModel user = AuthUserModel(
        email: _emailField.controller.text,
        password: _passwordField.controller.text,
      );

      BlocProvider.of<AuthCubit>(context).signIn(user);
    } else {
      setState(() {
        _autoValidateMode = AutovalidateMode.always;
      });
    }
  }

  void _updateEmailTextDirection(String? text) {
    if (text == null || text.trim().isEmpty) {
      setState(() => _emailTextDirection = null);
      return;
    }

    final hasArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(text);
    final hasEnglish = RegExp(r'[a-zA-Z]').hasMatch(text);

    if (hasArabic) {
      setState(() => _emailTextDirection = TextDirection.rtl);
    } else if (hasEnglish) {
      setState(() => _emailTextDirection = TextDirection.ltr);
    }
  }

  void _updatePassTextDirection(String? text) {
    if (text == null || text.trim().isEmpty) {
      setState(() => _passTextDirection = null);
      return;
    }
    final hasArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(text);
    final hasEnglish = RegExp(r'[a-zA-Z]').hasMatch(text);

    if (hasArabic) {
      setState(() => _passTextDirection = TextDirection.rtl);
    } else if (hasEnglish) {
      setState(() => _passTextDirection = TextDirection.ltr);
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
            textDirection: _emailTextDirection,
            keyType: TextInputType.emailAddress,
            labelText: "البريد الالكتروني",
            controller: _emailField.controller,
            validator: _emailField.validator,
            onChanged: _updateEmailTextDirection,
          ),
          SizedBox(height: 16),
          PasswordField(
            labelText: "كلمة المرور",
            textDirection: _passTextDirection,
            controller: _passwordField.controller,
            validator: _passwordField.validator,
            obscureText: _passwordField.isSecure,
            toggleVisibility: () {
              setState(() {
                _passwordField.isSecure = !_passwordField.isSecure;
              });
            },
            onChanged: _updatePassTextDirection,
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text("ليس لديك حساب؟"),
              TextButton(
                onPressed: () {
                  GoRouter.of(context).push(AppRouter.kregistrationView);
                },
                style: ButtonStyle(
                    overlayColor: WidgetStatePropertyAll(Colors.transparent)),
                child: Text("انشاء حساب"),
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
            return Column(
              children: [
                Text(
                  state is AuthStateError ? state.errorMsg : "",
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 100),
                CustomButton(
                  title: "تسجيل الدخول",
                  onPress: _submit,
                  isLoading: state is AuthStateLoading,
                )
              ],
            );
          }),
        ],
      ),
    );
  }
}
