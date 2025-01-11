import 'package:UpDown/core/widgets/header_text.dart';
import 'package:flutter/material.dart';

import 'registration_form.dart';

class RegistrationViewBody extends StatelessWidget {
  const RegistrationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const HeaderText(title: "انشاء حساب جديد", textSize: 26),
            const SizedBox(height: 50),
            RegistrationForm(),
          ],
        ),
      )),
    );
  }
}
