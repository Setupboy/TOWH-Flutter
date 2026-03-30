import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:towh/core/storage/app_preferences.dart';
import 'package:towh/core/theme/app_colors.dart';
import 'package:towh/core/theme/app_fonts.dart';

Future<void> showCookieConsentDialogIfNeeded(BuildContext context) async {
  if (AppPreferences.instance.hasAnsweredCookieConsent) {
    return;
  }

  final accepted = await showAdaptiveDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      final platform = Theme.of(dialogContext).platform;
      final isCupertino =
          platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

      if (isCupertino) {
        return CupertinoAlertDialog(
          title: const Text('Allow cookies on this device?'),
          content: const Padding(
            padding: EdgeInsets.only(top: 12),
            child: Text(
              'We use cookies and similar local storage to remember your app '
              'preferences and improve your experience.',
            ),
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Not now'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Allow'),
            ),
          ],
        );
      }

      return AlertDialog(
        backgroundColor: kColorWhite50,
        title: const Text(
          'Allow cookies on this device?',
          style: TextStyle(
            fontFamily: kFontBaloo2,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: kColorBlue900,
          ),
        ),
        content: const Text(
          'We use cookies and similar local storage to remember your app '
          'preferences and improve your experience.',
          style: TextStyle(
            fontFamily: kFontMPL,
            fontSize: 15,
            height: 1.5,
            color: kColorBlue800,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text(
              'Not now',
              style: TextStyle(
                fontFamily: kFontMPL,
                fontWeight: FontWeight.w500,
                color: kColorBlue800,
              ),
            ),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: kColorYellow200,
              foregroundColor: kColorBlue900,
            ),
            child: const Text(
              'Allow',
              style: TextStyle(
                fontFamily: kFontMPL,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
    },
  );

  await AppPreferences.instance.setCookieConsent(accepted: accepted ?? false);
}
