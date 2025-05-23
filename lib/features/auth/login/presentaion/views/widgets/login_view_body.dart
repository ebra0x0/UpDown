import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/header_text.dart';
import 'package:UpDown/features/auth/login/presentaion/views/widgets/login_form.dart';
import 'package:flutter/material.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            HeaderText(
              title: "أهلاً من جديد",
              textStyle: Styles.textStyle26,
            ),
            HeaderText(
              title: "هيا نسجل الدخول لحسابك",
              textStyle: Styles.textStyle16,
            ),
            const SizedBox(height: 50),
            LoginForm(),
          ],
        ),
      )),
    );
  }
}
