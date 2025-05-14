import 'package:UpDown/features/auth/manager/auth_cubit.dart';
import 'package:UpDown/features/auth/registration/presentation/views/widgets/registration_submit_section.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationSubmitSectionBuilder extends StatelessWidget {
  const RegistrationSubmitSectionBuilder({super.key, required this.submit});

  final void Function() submit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return RegistrationSubmitSection(state: state, submit: submit);
    });
  }
}
