import 'package:flutter/material.dart';
import '../../core/shared_pref.dart';

class LanguageProvider with ChangeNotifier {
  final SharedPrefs sharedPrefs;
  Locale _locale = Locale('en');
  LanguageProvider(this.sharedPrefs);

  Locale get locale => _locale;

  Future<bool> loadLanguage() async {
    final savedLang = await sharedPrefs.getLanguage();
    if (savedLang != null) {
      _locale = Locale(savedLang);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> setLanguage(String languageCode) async {
    _locale = Locale(languageCode);
    await sharedPrefs.saveLanguage(languageCode);
    notifyListeners();
  }
}
