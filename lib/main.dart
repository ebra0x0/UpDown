import 'package:UpDown/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'constants.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: kSUPABASE_URL,
    anonKey: kSUPABASE_KEY,
  );
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
