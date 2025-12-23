import 'package:UpDown/core/di/dependancy_injection.dart';
import 'package:UpDown/core/network/network_cubit.dart';
import 'package:UpDown/core/router/app_router.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/l10n/local_service.dart';
import 'package:UpDown/core/theme/cubit/theme_cubit.dart';
import 'package:UpDown/features/auth/ui/cubit/auth_cubit.dart';
import 'package:UpDown/l10n/generated/app_localizations.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpDown extends StatelessWidget {
  const UpDown({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ThemeCubit>()),
        BlocProvider(create: (context) => getIt<NetworkCubit>()),
        BlocProvider(create: (context) => getIt<AuthCubit>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: BlocConsumer<ThemeCubit, ThemeMode>(
          buildWhen: (prev, curr) => prev != curr,
          listener: (context, mode) {
            final brightness =
                WidgetsBinding.instance.platformDispatcher.platformBrightness;
            final actual = _getActualBrightness(mode, brightness);
            AppTheme.setTheme(mode: mode, bright: brightness);
            _setSystemUIOverlayStyle(actual);
          },
          builder: (context, themeMode) {
            return MaterialApp.router(
              routerConfig: AppRouter.router(),
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
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
            );
          },
        ),
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
        systemNavigationBarColor: AppTheme.scaffoldColor,
        systemNavigationBarIconBrightness: brightness,
      ),
    );
  }
}
