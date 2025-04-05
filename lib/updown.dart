import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/utils/manager/auth_cubit/cubit/auth_cubit.dart';
import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/service_locator.dart';
import 'package:UpDown/l10n/generated/app_localizations.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class UpDown extends StatelessWidget {
  const UpDown({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: gitIt.get<AppRouter>().router(context.read<AuthCubit>()),
      debugShowCheckedModeBanner: false,
      supportedLocales: [
        Locale('en', 'US'), // English
        Locale('ar', 'AE'), // Arabic
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate
      ],
      locale: Locale('ar', 'AE'),
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Pallete.lightPrimary,
        textTheme: GoogleFonts.notoKufiArabicTextTheme(),
      ),
    );
  }
}
