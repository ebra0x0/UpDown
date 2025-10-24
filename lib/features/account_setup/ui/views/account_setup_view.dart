import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/helper/toast.dart';
import 'package:UpDown/features/account_setup/ui/cubit/account_setup_cubit.dart';
import 'package:UpDown/features/account_setup/ui/widgets/account_setup_view_body.dart';
import 'package:UpDown/features/auth/ui/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountSetupView extends StatelessWidget {
  const AccountSetupView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountSetupCubit, AccountSetupState>(
      listener: (context, state) async {
        if (state.status == AccountSetupStatus.error) {
          showToast(
              context: context, message: state.error!, type: ToastType.error);
        } else if (state.status == AccountSetupStatus.success) {
          showToast(
              context: context,
              message: "تم إعداد الملف الشخصي بنجاح",
              type: ToastType.success);

          context.read<AuthCubit>().updateStatus(AuthStatus.authenticated);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'إعداد الملف الشخصي',
            style: AppTextStyles.textStyle22,
          ),
        ),
        body: AccountSetupViewBody(),
      ),
    );
  }
}
