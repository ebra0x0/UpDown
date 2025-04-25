import 'package:UpDown/features/account_setup/presentation/views/widgets/account_setup_view_body.dart';
import 'package:flutter/material.dart';

class AccountSetupView extends StatelessWidget {
  const AccountSetupView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إعداد الملف الشخصي'),
      ),
      body: AccountSetupViewBody(),
    );
  }
}
