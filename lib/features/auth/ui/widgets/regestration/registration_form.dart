import 'package:UpDown/core/theme/app_icons.dart';
import 'package:UpDown/core/utils/constants/validators/validator.dart';
import 'package:UpDown/core/widgets/custom_text_form_field.dart';
import 'package:UpDown/core/widgets/password_field.dart';
import 'package:UpDown/core/utils/model/form_field_model.dart';
import 'package:UpDown/features/auth/ui/cubit/auth_cubit.dart';
import 'package:UpDown/features/auth/ui/widgets/regestration/registration_submit_builder.dart';
import 'package:flutter/widgets.dart';
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
    validator: Validator.emailValidator,
  );

  final FormFieldModel _passwordField = FormFieldModel(
    labelText: "كلمة المرور",
    isPassword: true,
    isSecure: true,
    validator: Validator.regestrationPasswordValidator,
  );

  final FormFieldModel _rePasswordField = FormFieldModel(
    labelText: "تأكيد كلمة المرور",
    isPassword: true,
    isConfirmPassword: true,
    isSecure: true,
  );

  void _submit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      FocusScope.of(context).unfocus();

      final String email = _emailField.controller.text.trim();
      final String pass = _passwordField.controller.text.trim();

      await context.read<AuthCubit>().signUp(email: email, password: pass);
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
            formKey: formKey,
            keyType: TextInputType.emailAddress,
            labelText: _emailField.labelText,
            controller: _emailField.controller,
            validator: _emailField.validator,
            prefixIcon: AppIcons.emailIcon,
          ),
          PasswordField(
            labelText: _passwordField.labelText,
            controller: _passwordField.controller,
            validator: _passwordField.validator,
            obscureText: _passwordField.isSecure,
            toggleVisibility: () => setState(
                () => _passwordField.isSecure = !_passwordField.isSecure),
          ),
          PasswordField(
            labelText: _rePasswordField.labelText,
            controller: _rePasswordField.controller,
            validator: (value) => Validator.confirmPasswordValidator(
              password: _passwordField.controller.text,
              rePassword: value,
            ),
            obscureText: _rePasswordField.isSecure,
            toggleVisibility: () => setState(
                () => _rePasswordField.isSecure = !_rePasswordField.isSecure),
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
