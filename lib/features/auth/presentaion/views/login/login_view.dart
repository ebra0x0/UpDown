import 'package:UpDown/core/widgets/back_nav_button.dart';
import 'package:flutter/material.dart';
import 'widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: BackButtonNavigation(),
        ),
        body: LoginViewBody());
  }
}
