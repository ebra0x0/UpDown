import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/widgets/back_nav_button.dart';
import 'package:UpDown/features/auth/presentaion/views/confirmation/widgets/build_action_section.dart';
import 'package:flutter/material.dart';

class ConfirmationView extends StatelessWidget {
  const ConfirmationView({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButtonNavigation(route: AppRouter.kloginView),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'برجاء التحقق من بريدك الالكتروني لتفعيل الحساب',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              BuildActionSection(email: email),
            ],
          ),
        ),
      ),
    );
  }
}
