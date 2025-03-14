import 'dart:ui';

class SupportedLocales {
  static const en = Locale('en');
  static const pl = Locale('pl');
  static const fr = Locale('fr');

  static String localeToString(Locale locale) {
    return switch (locale) {
      en => 'English',
      pl => 'Polski',
      fr => 'Français',
      _ => '',
    };
  }
}
