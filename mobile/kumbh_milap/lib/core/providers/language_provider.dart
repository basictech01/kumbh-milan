import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  Locale _locale = Locale('en');

  Locale get locale => _locale;

  void changeLanguage(String langCode) {
    if (langCode == 'hi') {
      _locale = Locale('hi');
    } else {
      _locale = Locale('en');
    }
    notifyListeners();
  }
}
