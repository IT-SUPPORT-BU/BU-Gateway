import 'package:flutter/material.dart';
import 'settings_controller.dart';

class AppLocalizations {
  final AppLanguage language;

  AppLocalizations(this.language);

  static AppLocalizations of(BuildContext context) {
    final settings = SettingsProvider.of(context);
    return AppLocalizations(settings.language);
  }

  static const Map<AppLanguage, Map<String, String>> _translations = {
    AppLanguage.english: {
      'appTitle': 'BU Gateway',
      'welcomeMessage': 'Welcome to BU Gateway',
      'slogan': 'Excellence in Service',
      'searchPlaceholder': 'Search university platforms...',
      'noResults': 'No platforms found matching your search',
      'settingsTitle': 'Settings',
      'appearanceLabel': 'Appearance',
      'darkModeLabel': 'Dark Mode',
      'languageLabel': 'Language',
      'storageLabel': 'Storage',
      'cachedDataLabel': 'Cached data',
      'clearCacheButton': 'Clear Cache',
      'cacheClearedMessage': 'Cache cleared successfully',
      'preferencesSavedNote': 'Your preferences are saved locally and restored automatically.',
      'footerCopyright': '© 2026 Bugema University · IT Support in collaboration with Intern Students of 2026',
      'toggleThemeTooltip': 'Toggle Theme',
      'bugemaCompanion': 'Bugema University Companion Portal',
    },
    AppLanguage.luganda: {
      'appTitle': 'BU Gateway',
      'welcomeMessage': 'Tuwanirize ku BU Gateway',
      'slogan': 'Obuvumu mu Kukuŋŋaanya',
      'searchPlaceholder': 'Laba ku bifaananyi bya yunivasite...',
      'noResults': 'Tewali bibinja ebyewani mu kusolola kwo',
      'settingsTitle': 'Ebitegekeso',
      'appearanceLabel': 'Obuwonero',
      'darkModeLabel': 'Olukunkuma',
      'languageLabel': 'Olulimi',
      'storageLabel': 'Ebikwetegeredde',
      'cachedDataLabel': 'Ebikwata ebyekozesebwa',
      'clearCacheButton': 'Fuga Ebikwatako',
      'cacheClearedMessage': 'Ebikwatako byeyasuliddwa nga bulungi',
      'preferencesSavedNote': 'Enkola zo ezisembwa zinaabika mu kitongole era zikyusibwa nga bwetunaaba.',
      'footerCopyright': '© 2026 Bugema University · IT Support in collaboration with Intern Students of 2026',
      'toggleThemeTooltip': 'Kuzzaamu okukooma',
      'bugemaCompanion': 'Ekibinja kyebyobusuubuzi ky’Yunivasite ya Bugema',
    },
    AppLanguage.swahili: {
      'appTitle': 'BU Gateway',
      'welcomeMessage': 'Karibu kwenye BU Gateway',
      'slogan': 'Ubora Katika Huduma',
      'searchPlaceholder': 'Tafuta majukwaa ya chuo...',
      'noResults': 'Hakuna majukwaa yaliyopatikana kwa utafutaji wako',
      'settingsTitle': 'Mipangilio',
      'appearanceLabel': 'Muonekano',
      'darkModeLabel': 'Njia Nyeusi',
      'languageLabel': 'Lugha',
      'storageLabel': 'Uhifadhi',
      'cachedDataLabel': 'Data iliyohifadhiwa',
      'clearCacheButton': 'Futa Kache',
      'cacheClearedMessage': 'Kache imeshekwa kwa mafanikio',
      'preferencesSavedNote': 'Mapendeleo yako yamehifadhiwa ndani na kurejeshwa moja kwa moja.',
      'footerCopyright': '© 2026 Bugema University · IT Support in collaboration with Intern Students of 2026',
      'toggleThemeTooltip': 'Badilisha Mandhari',
      'bugemaCompanion': 'Lango la Msaidizi wa Chuo Kikuu cha Bugema',
    },
  };

  String _translate(String key) {
    return _translations[language]?[key] ?? _translations[AppLanguage.english]![key]!;
  }

  String get appTitle => _translate('appTitle');
  String get welcomeMessage => _translate('welcomeMessage');
  String get slogan => _translate('slogan');
  String get searchPlaceholder => _translate('searchPlaceholder');
  String get noResults => _translate('noResults');
  String get settingsTitle => _translate('settingsTitle');
  String get appearanceLabel => _translate('appearanceLabel');
  String get darkModeLabel => _translate('darkModeLabel');
  String get languageLabel => _translate('languageLabel');
  String get storageLabel => _translate('storageLabel');
  String get cachedDataLabel => _translate('cachedDataLabel');
  String get clearCacheButton => _translate('clearCacheButton');
  String get cacheClearedMessage => _translate('cacheClearedMessage');
  String get preferencesSavedNote => _translate('preferencesSavedNote');
  String get footerCopyright => _translate('footerCopyright');
  String get toggleThemeTooltip => _translate('toggleThemeTooltip');
  String get bugemaCompanion => _translate('bugemaCompanion');
}
