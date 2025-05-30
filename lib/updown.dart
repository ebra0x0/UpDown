import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/utils/localization/local_service.dart';
import 'package:UpDown/core/utils/manager/theme_cubit.dart';
import 'package:UpDown/l10n/generated/app_localizations.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpDown extends StatelessWidget {
  const UpDown({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        buildWhen: (prev, curr) => prev != curr,
        builder: (context, themeMode) {
          final brightness =
              WidgetsBinding.instance.platformDispatcher.platformBrightness;

          final Brightness actualBrightness =
              _getActualBrightness(themeMode, brightness);

          // Set the theme based on the current theme mode
          AppTheme.setTheme(mode: themeMode, bright: brightness);
          final theme = AppTheme.themeData;

          // Set the system UI overlay style based on the actual brightness
          _setSystemUIOverlayStyle(actualBrightness);

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
            locale: Locale('ar', 'AE'), // Default to Arabic
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              final chosen = supportedLocales.firstWhere(
                (locale) => locale.languageCode == deviceLocale?.languageCode,
                orElse: () => Locale('ar', 'AE'),
              );

              LocaleService.updateLocale(chosen.languageCode);
              return chosen;
            },
            theme: theme,
            darkTheme: theme,
            themeMode: themeMode,
          );
        },
      ),
    );
  }

  Brightness _getActualBrightness(ThemeMode mode, Brightness systemBrightness) {
    switch (mode) {
      case ThemeMode.dark:
        return Brightness.dark;
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.system:
        return systemBrightness;
    }
  }

  void _setSystemUIOverlayStyle(Brightness brightness) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: AppTheme.scaffold,
        systemNavigationBarIconBrightness: brightness,
      ),
    );
  }
}
