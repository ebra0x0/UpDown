import 'package:UpDown/core/widgets/back_nav_button.dart';
import 'package:UpDown/features/auth/presentaion/manager/registration_cubit/registration_cubit.dart';
import 'package:UpDown/features/auth/presentaion/views/registration/widgets/registartion_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegistrationCubit>(
        create: (context) => RegistrationCubit(),
        child: Scaffold(
            appBar: AppBar(
              title: BackButtonNavigation(),
            ),
            body: RegistrationViewBody()));
  }
}
