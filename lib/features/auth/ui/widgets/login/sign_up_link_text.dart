import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/enums/app_route.dart';
import 'package:UpDown/features/auth/ui/cubit/auth_cubit.dart';
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
            context.push(AppRoute.registration.path);
          },
          style: ButtonStyle(
              overlayColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.primary)),
          child: Text("إنشاء حساب",
              style: AppTextStyles.textStyle14.copyWith(
                color: AppTheme.primary,
              )),
        )
      ],
    );
  }
}
