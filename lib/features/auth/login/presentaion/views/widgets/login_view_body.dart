import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/widgets/header_section.dart';
import 'package:UpDown/features/auth/login/presentaion/views/widgets/login_form.dart';
import 'package:flutter/widgets.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
          child: Padding(
        padding: AppInsets.h16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            HeaderSection(
              title: "أهلاً من جديد",
              titleStyle: AppTextStyles.textStyle26,
            ),
            HeaderSection(
              title: "هيا نسجل الدخول لحسابك",
              titleStyle: AppTextStyles.textStyle16,
            ),
            const SizedBox(height: 50),
            LoginForm(),
          ],
        ),
      )),
    );
  }
}
