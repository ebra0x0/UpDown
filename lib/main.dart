import 'package:UpDown/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'constants.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // Match this with the app's theme
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  runApp(const UpDown());
}

class UpDown extends StatelessWidget {
  const UpDown({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
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
        primaryColor: kprimaryColor,
      ),
    );
  }
}
