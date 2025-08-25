import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/features/account_setup/ui/widgets/account_setup_form.dart';
import 'package:flutter/widgets.dart';

class AccountSetupViewBody extends StatelessWidget {
  const AccountSetupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.h16,
      child: AccountSetupForm(),
    );
  }
}
