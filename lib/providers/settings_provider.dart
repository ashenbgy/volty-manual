import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  Locale _locale = const Locale('en');
  List<String> _favoritePartCodes = [];
  SharedPreferences? _prefs;

  Locale get locale => _locale;
  List<String> get favoritePartCodes => _favoritePartCodes;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    
    // Load Locale
    String? languageCode = _prefs?.getString('language_code');
    if (languageCode != null) {
      _locale = Locale(languageCode);
    }
    
    // Load Favorites
    _favoritePartCodes = _prefs?.getStringList('favorite_parts') ?? [];
    notifyListeners();
  }

  Future<void> setLocale(Locale newLocale) async {
    _locale = newLocale;
    await _prefs?.setString('language_code', newLocale.languageCode);
    notifyListeners();
  }

  bool isFavorite(String partCode) {
    return _favoritePartCodes.contains(partCode);
  }

  Future<void> toggleFavorite(String partCode) async {
    if (_favoritePartCodes.contains(partCode)) {
      _favoritePartCodes.remove(partCode);
    } else {
      _favoritePartCodes.add(partCode);
    }
    await _prefs?.setStringList('favorite_parts', _favoritePartCodes);
    notifyListeners();
  }
}
