import 'package:UpDown/core/utils/function/toast.dart';
import 'package:UpDown/core/utils/manager/auth_cubit/cubit/auth_cubit.dart';
import 'package:UpDown/core/utils/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthStateError) {
          showToast(
              context,
              state.errorMsg,
              Icon(
                Icons.error_outline_rounded,
                color: Pallete.lightError,
              ));
        }
      },
      child: Scaffold(body: SafeArea(child: LoginViewBody())),
    );
  }
}
