import 'package:UpDown/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpLinkText extends StatelessWidget {
  const SignUpLinkText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("ليس لديك حساب؟"),
        TextButton(
          onPressed: () {
            context.push(AppRouter.kregistrationView);
          },
          style: ButtonStyle(
              overlayColor: WidgetStatePropertyAll(Colors.transparent)),
          child: Text("انشاء حساب"),
        )
      ],
    );
  }
}
