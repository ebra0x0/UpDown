import 'package:UpDown/features/auth/manager/auth_cubit.dart';
import 'package:UpDown/features/auth/login/presentaion/views/widgets/login_submit_section.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginSubmitSectionBuilder extends StatelessWidget {
  const LoginSubmitSectionBuilder({super.key, required this.submit});
  final void Function() submit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return LoginSubmitSection(state: state, submit: submit);
    });
  }
}
