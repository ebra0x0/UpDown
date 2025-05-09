import 'package:UpDown/core/utils/manager/auth_cubit/cubit/auth_cubit.dart';
import 'package:UpDown/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class RegistrationSubmitSection extends StatelessWidget {
  const RegistrationSubmitSection(
      {super.key, required this.state, required this.submit});

  final AuthState state;
  final void Function() submit;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      title: "إنشاء حساب",
      onPress: submit,
      isLoading: state is AuthStateLoading,
    );
  }
}
