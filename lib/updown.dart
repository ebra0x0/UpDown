import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/l10n/generated/app_localizations.dart';
import "package:flutter/material.dart";
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class UpDown extends StatelessWidget {
  const UpDown({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter.router(context),
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
        primaryColorLight: Pallete.lightPrimary,
        primaryColorDark: Pallete.darkPrimary,
        scaffoldBackgroundColor: Pallete.lightScaffoldBackground,
        useMaterial3: true,
        primaryColor: Pallete.lightPrimary,
        textTheme: GoogleFonts.notoKufiArabicTextTheme(),
      ),
    );
  }
}
