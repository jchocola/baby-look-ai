import 'dart:ui';

String languageConverter(Locale locale) {
  switch (locale.languageCode) {
    case 'en':
      return 'English';
    case 'vi':
      return 'Vietnamese - Tiếng Việt';
    case 'ru':
      return 'Russian - Русский';
    default:
      return 'Unknown';
  }
}
