import 'package:UpDown/core/utils/function/toast.dart';
import 'package:UpDown/core/widgets/back_nav_button.dart';
import 'package:UpDown/features/auth/manager/auth_cubit.dart';
import 'package:UpDown/features/auth/registration/presentation/views/widgets/registartion_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unconfirmed) {
          showToast(
              context: context,
              message: "تم انشاء الحساب , تابع رسائل بريدك لتفعيل الحساب",
              type: ToastType.success);
        } else if (state.status == AuthStatus.error) {
          showToast(
              context: context,
              message: state.errorMsg!,
              type: ToastType.error);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            leading: BackButtonNavigation(),
          ),
          body: RegistrationViewBody()),
    );
  }
}
