import 'package:UpDown/features/auth/manager/auth_cubit.dart';
import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().sessionMonitor();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: LoadingIndicator(
      size: 28,
    ));
  }
}
