import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_keys.dart';

enum AppLanguage { english, luganda, swahili }

extension AppLanguageExtension on AppLanguage {
  String get code {
    switch (this) {
      case AppLanguage.english:
        return 'en';
      case AppLanguage.luganda:
        return 'lg';
      case AppLanguage.swahili:
        return 'sw';
    }
  }

  String get label {
    switch (this) {
      case AppLanguage.english:
        return 'English';
      case AppLanguage.luganda:
        return 'Luganda';
      case AppLanguage.swahili:
        return 'Swahili';
    }
  }

  static AppLanguage fromCode(String? code) {
    switch (code) {
      case 'lg':
        return AppLanguage.luganda;
      case 'sw':
        return AppLanguage.swahili;
      case 'en':
      default:
        return AppLanguage.english;
    }
  }
}

class SettingsController extends ChangeNotifier {
  bool _isDarkMode = false;
  AppLanguage _language = AppLanguage.english;

  bool get isDarkMode => _isDarkMode;
  AppLanguage get language => _language;

  SettingsController();

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(SettingsKeys.isDarkMode) ?? false;
    _language = AppLanguageExtension.fromCode(prefs.getString(SettingsKeys.languageCode));
    notifyListeners();
  }

  Future<void> updateDarkMode(bool enabled) async {
    _isDarkMode = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SettingsKeys.isDarkMode, enabled);
    notifyListeners();
  }

  Future<void> updateLanguage(AppLanguage language) async {
    _language = language;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SettingsKeys.languageCode, language.code);
    notifyListeners();
  }
}

class SettingsProvider extends InheritedNotifier<SettingsController> {
  const SettingsProvider({super.key, required SettingsController notifier, required Widget child}) : super(notifier: notifier, child: child);

  static SettingsController of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<SettingsProvider>();
    assert(provider != null, 'No SettingsProvider found in context');
    return provider!.notifier!;
  }
}
