import 'package:UpDown/features/auth/presentaion/manager/registration_cubit/registration_cubit.dart';
import 'package:UpDown/features/auth/presentaion/views/widgets/registartion_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationView extends StatelessWidget {
  static const String id = "/Registration_view";

  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegistrationCubit>(
        create: (context) => RegistrationCubit(),
        child: Scaffold(body: RegistrationViewBody()));
  }
}
