import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class AppPreferences {
  AppPreferences._();

  static final AppPreferences instance = AppPreferences._();

  static const String _fileName = 'app_preferences.json';
  static const String _hasSeenOnboardingKey = 'hasSeenOnboarding';

  late final File _file;
  Map<String, dynamic> _data = <String, dynamic>{};
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    final directory = await getApplicationDocumentsDirectory();
    _file = File('${directory.path}/$_fileName');

    if (await _file.exists()) {
      final content = await _file.readAsString();
      if (content.trim().isNotEmpty) {
        _data = Map<String, dynamic>.from(
          jsonDecode(content) as Map<String, dynamic>,
        );
      }
    }

    _initialized = true;
  }

  bool get hasSeenOnboarding =>
      (_data[_hasSeenOnboardingKey] as bool?) ?? false;

  Future<void> setHasSeenOnboarding(bool value) async {
    _data[_hasSeenOnboardingKey] = value;
    await _file.writeAsString(jsonEncode(_data));
  }
}
