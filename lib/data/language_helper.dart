import 'package:shared_preferences/shared_preferences.dart';

class LanguageHelper {
  static const _keyLanguage = 'language';

  static Future<void> saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_keyLanguage, languageCode);
  }

  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLanguage) ?? 'en'; // Default to English if no preference is saved
  }
}
