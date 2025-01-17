import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/widgets/custom_button.dart';
import 'package:UpDown/core/widgets/custom_text_form_field.dart';
import 'package:UpDown/core/widgets/password_field.dart';
import 'package:UpDown/core/utils/model/auth_user_model.dart';
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
  final _FormKey = GlobalKey<FormState>();
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

  Future<void> _submit() async {
    if (_FormKey.currentState!.validate()) {
      _FormKey.currentState!.save();
      final AuthUserModel user = AuthUserModel(
        email: _emailField.controller.text,
        password: _passwordField.controller.text,
      );

      await BlocProvider.of<LoginCubit>(context).login(user);
    } else {
      setState(() {
        _autoValidateMode = AutovalidateMode.always;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _FormKey,
      autovalidateMode: _autoValidateMode,
      child: Column(
        children: [
          CustomTextFormField(
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
    );
  }
}
