import 'package:UpDown/core/widgets/custom_button.dart';
import 'package:UpDown/features/auth/manager/auth_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginSubmitSectionBuilder extends StatelessWidget {
  const LoginSubmitSectionBuilder({super.key, required this.submit});
  final void Function() submit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) => CustomButton(
              title: "تسجيل الدخول",
              onPress: submit,
              isLoading: state.status == AuthStatus.loading,
            ));
  }
}
