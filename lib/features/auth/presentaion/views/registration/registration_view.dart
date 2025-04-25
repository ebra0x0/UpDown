import 'package:UpDown/core/utils/manager/auth_cubit/cubit/auth_cubit.dart';
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
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('تابع رسائل بريدك لتفعيل الحساب'),
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
