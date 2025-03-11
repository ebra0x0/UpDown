import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/utils/function/api_initialization.dart';
import 'package:UpDown/core/utils/function/toast.dart';
import 'package:UpDown/core/utils/manager/auth_cubit/cubit/auth_cubit.dart';
import 'package:UpDown/core/utils/manager/user_cubit/cubit/user_data_cubit.dart';
import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/service_locator.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  WidgetsFlutterBinding.ensureInitialized();

  await apiInitialization();
  setupServiceLocator();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => AuthCubit()..authMonitor()),
    BlocProvider(create: (context) => UserDataCubit()),
  ], child: const UpDown()));
}

class UpDown extends StatelessWidget {
  const UpDown({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = AppRouter.router;
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => AppBuilder(
        router: router,
        child: child,
      ),
      supportedLocales: [
        Locale('en', 'US'), // English
        Locale('ar', 'AE'), // Arabic
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('ar', 'AE'),
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Pallete.primary,
        textTheme: GoogleFonts.notoKufiArabicTextTheme(),
      ),
    );
  }
}

class AppBuilder extends StatelessWidget {
  const AppBuilder({super.key, required this.router, required this.child});

  final GoRouter router;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateAuthenticated) {
          await BlocProvider.of<UserDataCubit>(context)
              .loadUserData(user: state.user);

          router.go(AppRouter.khomeView);
        } else if (state is AuthStateError) {
          showToast(context, state.errorMsg);
        } else {
          BlocProvider.of<UserDataCubit>(context).reset();
          router.go(AppRouter.kloginView);
        }
      },
      child: child,
    );
  }
}
