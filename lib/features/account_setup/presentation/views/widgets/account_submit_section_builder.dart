import 'package:UpDown/core/widgets/custom_button.dart';
import 'package:UpDown/features/account_setup/presentation/manager/account_setup_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountSubmitSectionBuilder extends StatelessWidget {
  final void Function() submit;
  const AccountSubmitSectionBuilder({super.key, required this.submit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountSetupCubit, AccountSetupState>(
        builder: (context, state) => CustomButton(
              isLoading: state.status == AccountSetupStatus.loading,
              onPress: submit,
              title: "حفظ",
            ));
  }
}
