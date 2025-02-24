import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/widgets/custom_button.dart';
import 'package:UpDown/core/widgets/custom_text_form_field.dart';
import 'package:UpDown/core/widgets/password_field.dart';
import 'package:UpDown/features/auth/data/model/auth_user_model.dart';
import 'package:UpDown/core/utils/model/form_field_model.dart';
import 'package:UpDown/features/auth/presentaion/manager/login_cubit/login_cubit.dart';
import 'package:UpDown/features/auth/presentaion/manager/login_cubit/login_cubit_state.dart';
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
      final AuthUserModel user = AuthUserModel(
        email: _emailField.controller.text,
        password: _passwordField.controller.text,
      );

      BlocProvider.of<LoginCubit>(context).login(user);
    } else {
      setState(() {
        _autoValidateMode = AutovalidateMode.always;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginCubitState>(
      listener: (context, state) {
        if (state is LoginCubitSuccess) {
          context.go(AppRouter.khomeView);
        }
      },
      child: Form(
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
            BlocBuilder<LoginCubit, LoginCubitState>(builder: (context, state) {
              return Text(
                state is LoginCubitError ? state.error : "",
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              );
            }),
            SizedBox(height: 100),
            BlocBuilder<LoginCubit, LoginCubitState>(builder: (context, state) {
              return CustomButton(
                title: "تسجيل الدخول",
                onPress: _submit,
                isLoading: state is LoginCubitLoading,
              );
            }),
          ],
        ),
      ),
    );
  }
}
