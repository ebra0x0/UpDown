import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/header_text.dart';
import 'package:flutter/material.dart';

import 'registration_form.dart';

class RegistrationViewBody extends StatelessWidget {
  const RegistrationViewBody({super.key});

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
              title: "انشاء حساب جديد",
              textStyle: Styles.textStyle26,
            ),
            const SizedBox(height: 50),
            RegistrationForm(),
          ],
        ),
      )),
    );
  }
}
