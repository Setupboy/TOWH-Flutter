import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class AppPreferences {
  AppPreferences._();

  static final AppPreferences instance = AppPreferences._();

  static const String _fileName = 'app_preferences.json';
  static const String _hasSeenOnboardingKey = 'hasSeenOnboarding';
  static const String _hasAnsweredCookieConsentKey = 'hasAnsweredCookieConsent';
  static const String _hasAcceptedCookieConsentKey = 'hasAcceptedCookieConsent';

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

  bool get hasAnsweredCookieConsent =>
      (_data[_hasAnsweredCookieConsentKey] as bool?) ?? false;

  bool get hasAcceptedCookieConsent =>
      (_data[_hasAcceptedCookieConsentKey] as bool?) ?? false;

  Future<void> setHasSeenOnboarding(bool value) async {
    _data[_hasSeenOnboardingKey] = value;
    await _file.writeAsString(jsonEncode(_data));
  }

  Future<void> setCookieConsent({required bool accepted}) async {
    _data[_hasAnsweredCookieConsentKey] = true;
    _data[_hasAcceptedCookieConsentKey] = accepted;
    await _file.writeAsString(jsonEncode(_data));
  }
}
