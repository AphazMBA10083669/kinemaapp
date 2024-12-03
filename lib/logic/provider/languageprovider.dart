import 'package:flutter/material.dart';
import 'package:kinemaapp/data/translation.dart';

class LanguageProvider with ChangeNotifier {
  String _selectedLanguage = 'en'; // Default language
  Map<String, String> _texts = Translations.getTranslations('en');

  String get selectedLanguage => _selectedLanguage;
  Map<String, String> get texts => _texts;

  void changeLanguage(String languageCode) {
    _selectedLanguage = languageCode;
    _texts = Translations.getTranslations(languageCode);
    notifyListeners(); // Notify listeners to rebuild widgets
  }
}
