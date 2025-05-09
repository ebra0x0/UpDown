import 'package:UpDown/core/utils/function/toast.dart';
import 'package:UpDown/core/utils/manager/auth_cubit/cubit/auth_cubit.dart';
import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/widgets/back_nav_button.dart';
import 'package:UpDown/features/auth/presentaion/views/registration/widgets/registartion_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthStateUnconfirmed) {
          showToast(
              context,
              "تم انشاء الحساب , تابع رسائل بريدك لتفعيل الحساب",
              Icon(
                Icons.check_circle_outline_rounded,
                color: Pallete.lightSuccess,
              ));
        } else if (state is AuthStateError) {
          showToast(
              context,
              state.errorMsg,
              Icon(
                Icons.error_outline_rounded,
                color: Pallete.lightError,
              ));
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
