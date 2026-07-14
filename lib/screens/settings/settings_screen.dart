import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../../constants/colors.dart';
import '../../helpers/app_localizations.dart';
import '../../helpers/settings_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _cacheSizeBytes = 0;
  bool _isClearing = false;

  @override
  void initState() {
    super.initState();
    _refreshCacheSize();
  }

  Future<void> _refreshCacheSize() async {
    try {
      final dir = await getTemporaryDirectory();
      final size = await _getDirectorySize(dir);
      setState(() {
        _cacheSizeBytes = size;
      });
    } catch (_) {
      setState(() {
        _cacheSizeBytes = 0;
      });
    }
  }

  Future<int> _getDirectorySize(Directory dir) async {
    var total = 0;
    if (!await dir.exists()) return 0;
    await for (final entity in dir.list(recursive: true, followLinks: false)) {
      if (entity is File) {
        total += await entity.length();
      }
    }
    return total;
  }

  String get _cacheSizeLabel {
    const kb = 1024;
    const mb = kb * 1024;
    if (_cacheSizeBytes >= mb) {
      return '${(_cacheSizeBytes / mb).toStringAsFixed(1)} MB';
    }
    if (_cacheSizeBytes >= kb) {
      return '${(_cacheSizeBytes / kb).toStringAsFixed(1)} KB';
    }
    return '$_cacheSizeBytes B';
  }

  Future<void> _clearCache() async {
    setState(() {
      _isClearing = true;
    });
    try {
      final tempDir = await getTemporaryDirectory();
      if (await tempDir.exists()) {
        await for (final entity in tempDir.list(recursive: true, followLinks: false)) {
          try {
            if (entity is File) {
              await entity.delete();
            } else if (entity is Directory) {
              await entity.delete(recursive: true);
            }
          } catch (_) {
            // continue cleaning other files
          }
        }
      }
      await _refreshCacheSize();
      if (mounted) {
        final loc = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(loc.cacheClearedMessage)),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isClearing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = SettingsProvider.of(context);
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.settingsTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.appearanceLabel,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(loc.darkModeLabel),
                    Switch.adaptive(
                      value: settings.isDarkMode,
                      onChanged: (value) => settings.updateDarkMode(value),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              loc.languageLabel,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: DropdownButtonFormField<AppLanguage>(
                  value: settings.language,
                  decoration: const InputDecoration(border: InputBorder.none),
                  items: AppLanguage.values
                      .map(
                        (language) => DropdownMenuItem(
                          value: language,
                          child: Text(language.label),
                        ),
                      )
                      .toList(),
                  onChanged: (language) {
                    if (language != null) {
                      settings.updateLanguage(language);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              loc.storageLabel,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.cachedDataLabel,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _cacheSizeLabel,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: _isClearing ? null : _clearCache,
                      child: _isClearing
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(loc.clearCacheButton),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              loc.preferencesSavedNote,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
