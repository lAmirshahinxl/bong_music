import 'package:bong/src/config/languages/arabic_language.dart';
import 'package:bong/src/config/languages/english_language.dart';
import 'package:bong/src/config/languages/turkey_language.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Language {
  final List<String> _supportedLanguages = ["en", "tr", "ar"];
  final String _languageKey = "language";

  Map getCurrentLanguage() {
    switch (GetStorage().read(_languageKey)) {
      case 'en':
        return EnglishLanguage.data;
      case 'tr':
        return TurkeyLanguage.data;
      case 'ar':
        return ArabicLanguage.data;
      default:
        return EnglishLanguage.data;
    }
  }

  void setCurrentLanguage(String lang) {
    if (_supportedLanguages.contains(lang)) {
      GetStorage().write(_languageKey, lang);
    } else {
      GetStorage().write(_languageKey, _supportedLanguages.first);
    }
  }
}
