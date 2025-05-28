import 'package:UpDown/core/utils/service_locator.dart';
import 'package:UpDown/core/utils/styles.dart';
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
      create: (context) => AccountSetupCubit(gitIt.get<AccountSetupRepoImp>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'إعداد الملف الشخصي',
            style: Styles.textStyle24,
          ),
        ),
        body: AccountSetupViewBody(),
      ),
    );
  }
}
