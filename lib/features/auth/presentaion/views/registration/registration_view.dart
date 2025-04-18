import 'package:UpDown/core/widgets/back_nav_button.dart';
import 'package:UpDown/features/auth/presentaion/views/registration/widgets/registartion_view_body.dart';
import 'package:flutter/material.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButtonNavigation(),
        ),
        body: RegistrationViewBody());
  }
}
