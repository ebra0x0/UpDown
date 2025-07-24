import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/widgets/header_section.dart';
import 'package:flutter/widgets.dart';

import 'registration_form.dart';

class RegistrationViewBody extends StatelessWidget {
  const RegistrationViewBody({super.key});

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
              title: "انشاء حساب جديد",
              titleStyle: AppTextStyles.textStyle26,
            ),
            const SizedBox(height: 50),
            RegistrationForm(),
          ],
        ),
      )),
    );
  }
}
