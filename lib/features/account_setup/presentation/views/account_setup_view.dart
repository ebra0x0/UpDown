import 'package:UpDown/core/di/dependancy_injection.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/features/account_setup/data/repos/account_setup_repo_imp.dart';
import 'package:UpDown/features/account_setup/presentation/manager/account_setup_cubit.dart';
import 'package:UpDown/features/account_setup/presentation/views/widgets/account_setup_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountSetupView extends StatelessWidget {
  const AccountSetupView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountSetupCubit(AccountSetupRepoImp(getIt.get())),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'إعداد الملف الشخصي',
            style: AppTextStyles.textStyle24,
          ),
        ),
        body: AccountSetupViewBody(),
      ),
    );
  }
}
