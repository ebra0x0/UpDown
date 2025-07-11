class LocaleService {
  static String currentLocale = 'en'; // default

  static void updateLocale(String localeCode) {
    currentLocale = localeCode;
  }
}
