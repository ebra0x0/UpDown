import 'package:UpDown/core/utils/function/toast.dart';
import 'package:UpDown/features/account_setup/presentation/manager/account_setup_cubit.dart';
import 'package:UpDown/features/account_setup/presentation/views/widgets/account_setup_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountSetupViewBody extends StatelessWidget {
  const AccountSetupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountSetupCubit, AccountSetupState>(
      listener: (context, state) {
        if (state.status == AccountSetupStatus.error) {
          showToast(
              context: context, message: state.error!, type: ToastType.error);
        } else if (state.status == AccountSetupStatus.success) {
          showToast(
              context: context,
              message: "تم إعداد الملف الشخصي بنجاح",
              type: ToastType.success);
        }
      },
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: AccountSetupForm(),
      ),
    );
  }
}
