import 'package:UpDown/core/widgets/header_text.dart';
import 'package:UpDown/features/auth/presentaion/views/login/widgets/login_form.dart';
import 'package:flutter/material.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const HeaderText(title: "أهلاً من جديد", textSize: 28),
          const HeaderText(title: "هيا نسجل الدخول لحسابك", textSize: 18),
          const SizedBox(height: 50),
          LoginForm(),
        ],
      ),
    ));
  }
}
