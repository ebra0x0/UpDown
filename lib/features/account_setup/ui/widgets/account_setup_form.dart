import 'dart:io';
import 'package:UpDown/core/theme/app_icons.dart';
import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/utils/constants/validators/validator.dart';
import 'package:UpDown/core/utils/model/form_field_model.dart';
import 'package:UpDown/core/widgets/avatar_picker.dart';
import 'package:UpDown/core/widgets/custom_text_form_field.dart';
import 'package:UpDown/features/account_setup/ui/cubit/account_setup_cubit.dart';
import 'package:UpDown/features/account_setup/ui/widgets/account_submit_section_builder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountSetupForm extends StatefulWidget {
  const AccountSetupForm({
    super.key,
  });

  @override
  State<AccountSetupForm> createState() => _AccountSetupFormState();
}

class _AccountSetupFormState extends State<AccountSetupForm> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  final FormFieldModel _nameField = FormFieldModel(
    labelText: "الاسم",
    validator: Validator.nameValidator,
  );
  final FormFieldModel _phoneField = FormFieldModel(
    labelText: "رقم الهاتف",
    validator: Validator.phoneValidator,
  );
  final FormFieldModel _addressField = FormFieldModel(
    labelText: "العنوان",
    validator: Validator.addressValidator,
  );

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await context.read<AccountSetupCubit>().setup();
    } else {
      setState(() {
        _autoValidateMode = AutovalidateMode.always;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autoValidateMode,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: AppInsets.top26,
              child: AvatarPicker(
                  onImageSelected: (File image) =>
                      context.read<AccountSetupCubit>().setAvatar(image)),
            ),
            SizedBox(height: 28.h),
            CustomTextFormField(
              onChanged: (value) =>
                  context.read<AccountSetupCubit>().setName(value),
              labelText: _nameField.labelText,
              prefixIcon: AppIcons.badgeIcon,
              maxLength: 20,
              validator: _nameField.validator,
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              onChanged: (value) =>
                  context.read<AccountSetupCubit>().setPhone(value),
              labelText: _phoneField.labelText,
              prefixIcon: AppIcons.phoneIcon,
              validator: _phoneField.validator,
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              onChanged: (value) =>
                  context.read<AccountSetupCubit>().setAddress(value),
              labelText: _addressField.labelText,
              prefixIcon: AppIcons.locationIcon,
              validator: _addressField.validator,
              maxLength: 50,
            ),
            SizedBox(height: 32.h),
            AccountSubmitSectionBuilder(
              submit: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
