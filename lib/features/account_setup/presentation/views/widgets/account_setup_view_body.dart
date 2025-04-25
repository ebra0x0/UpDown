import 'package:UpDown/features/account_setup/presentation/views/widgets/account_setup_form.dart';
import 'package:flutter/widgets.dart';

class AccountSetupViewBody extends StatelessWidget {
  const AccountSetupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: AccountSetupForm(),
    );
  }
}
