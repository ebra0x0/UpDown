import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/utils/manager/auth_cubit.dart';
import 'package:UpDown/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthListener extends StatefulWidget {
  const AuthListener({super.key});

  @override
  State<AuthListener> createState() => _AuthListenerState();
}

class _AuthListenerState extends State<AuthListener> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) => {
        if (state is AuthSignedOut)
          {GoRouter.of(context).pushReplacement(AppRouter.kloginView)}
        else if (state is AuthSignedIn)
          {GoRouter.of(context).pushReplacement(AppRouter.khomeView)}
        else if (state is AuthError)
          {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)))
          }
        else if (state is AuthInitial)
          {GoRouter.of(context).pushReplacement(AppRouter.ksplashView)}
      },
      builder: (context, state) {
        return SplashView();
      },
    );
  }
}
