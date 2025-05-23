import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/features/auth/manager/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            BlocProvider.of<AuthCubit>(context).resetState();
            context.push(AppRouter.kregistrationView);
          },
          style: ButtonStyle(
              overlayColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.primary)),
          child: Text("إنشاء حساب",
              style: Styles.textStyle14.copyWith(
                color: AppTheme.grey,
              )),
        )
      ],
    );
  }
}
