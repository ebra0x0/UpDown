import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/helper/toast.dart';
import 'package:UpDown/features/auth/ui/cubit/auth_cubit.dart';
import 'package:UpDown/features/auth/ui/widgets/login/login_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.error) {
          showToast(
              context: context,
              message: state.errorMsg!,
              type: ToastType.error);
        }
      },
      child: Scaffold(body: SafeArea(child: LoginViewBody())),
    );
  }
}
