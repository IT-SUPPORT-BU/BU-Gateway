import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'constants/theme.dart';
import 'helpers/settings_controller.dart';
import 'screens/home/splash_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/settings/settings_screen.dart';

class BuGatewayApp extends StatefulWidget {
  const BuGatewayApp({super.key});

  @override
  State<BuGatewayApp> createState() => _BuGatewayAppState();
}

class _BuGatewayAppState extends State<BuGatewayApp> {
  late final SettingsController _settingsController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _settingsController = SettingsController()..addListener(_onSettingsChanged);
    _loadSettings();
  }

  void _onSettingsChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _loadSettings() async {
    await _settingsController.loadPreferences();
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _settingsController.removeListener(_onSettingsChanged);
    _settingsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SettingsProvider(
      notifier: _settingsController,
      child: MaterialApp(
        title: 'BU Gateway',
        debugShowCheckedModeBanner: false,
        theme: BUTheme.lightTheme,
        darkTheme: BUTheme.darkTheme,
        themeMode: _settingsController.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        locale: Locale(_settingsController.language.code),
        supportedLocales: const [
          Locale('en'),
          Locale('sw'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          if (locale == null) return const Locale('en');
          for (var supported in supportedLocales) {
            if (supported.languageCode == locale.languageCode) {
              return supported;
            }
          }
          return const Locale('en');
        },
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/dashboard': (context) => const HomeScreen(),
          '/settings': (context) => const SettingsScreen(),
        },
      ),
    );
  }
}

