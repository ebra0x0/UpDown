import 'package:UpDown/core/widgets/avatar_picker.dart';
import 'package:UpDown/core/widgets/custom_button.dart';
import 'package:UpDown/core/widgets/custom_text_form_field.dart';
import 'package:flutter/widgets.dart';
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  XFile? _image;

  final _phoneRegex = RegExp(r'^01[0125][0-9]{8}$');
  final _nameRegex =
      RegExp(r'^[\u0621-\u064Aa-zA-Z]{3,}(?: [\u0621-\u064Aa-zA-Z]{3,})*$');

  ValueChanged<XFile>? _handleImagePicked(XFile? image) {
    setState(() {
      _image = image;
    });
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUnfocus,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AvatarPicker(
              onImageSelected: _handleImagePicked,
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              controller: _nameController,
              labelText: "الاسم",
              validator: (value) {
                if (!_nameRegex.hasMatch(value!)) {
                  return 'الاسم غير صالح';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              controller: _phoneController,
              labelText: "رقم الهاتف",
              validator: (value) {
                if (!_phoneRegex.hasMatch(value!)) {
                  return 'رقم الهاتف غير صالح';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              controller: _addressController,
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
            SizedBox(height: 30),
            CustomButton(
              onPress: _submitForm,
              title: "حفظ",
            ),
          ],
        ),
      ),
    );
  }
}
