import 'package:UpDown/core/utils/normalization.dart';
import 'package:UpDown/core/widgets/avatar_picker.dart';
import 'package:UpDown/core/widgets/custom_text_form_field.dart';
import 'package:UpDown/features/account_setup/presentation/manager/account_setup_cubit.dart';
import 'package:UpDown/features/account_setup/presentation/views/widgets/account_submit_section_builder.dart';
import 'package:UpDown/features/auth/manager/auth_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

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

  final _phoneRegex = Normalization.kPhoneRegex;
  final _nameRegex = Normalization.kNameRegex;

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await context.read<AccountSetupCubit>().call();

      // ignore: use_build_context_synchronously
      if (context.read<AccountSetupCubit>().state.status ==
          AccountSetupStatus.success) {
        // ignore: use_build_context_synchronously
        await context.read<AuthCubit>().checkAccountStatus(
            // ignore: use_build_context_synchronously
            session: context.read<AuthCubit>().state.session!);
      }
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
            AvatarPicker(onImageSelected: (XFile image) {
              context.read<AccountSetupCubit>().setAvatar(image);
            }),
            SizedBox(height: 28.h),
            CustomTextFormField(
              onChanged: (value) =>
                  context.read<AccountSetupCubit>().setName(value),
              labelText: "الاسم",
              validator: (value) {
                if (!_nameRegex.hasMatch(value!)) {
                  return 'الاسم غير صالح';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              onChanged: (value) =>
                  context.read<AccountSetupCubit>().setPhone(value),
              labelText: "رقم الهاتف",
              validator: (value) {
                if (!_phoneRegex.hasMatch(value!)) {
                  return 'رقم الهاتف غير صالح';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              onChanged: (value) =>
                  context.read<AccountSetupCubit>().setAddress(value),
              labelText: "العنوان",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'العنوان مطلوب';
                } else if (value.length < 8) {
                  return 'العنوان قصير جداً';
                }
                return null;
              },
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
