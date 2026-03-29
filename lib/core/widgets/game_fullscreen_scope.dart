import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameFullscreenScope extends StatefulWidget {
  const GameFullscreenScope({super.key, required this.child});

  final Widget child;

  @override
  State<GameFullscreenScope> createState() => _GameFullscreenScopeState();
}

class _GameFullscreenScopeState extends State<GameFullscreenScope>
    with WidgetsBindingObserver {
  static const Duration _restoreDelay = Duration(milliseconds: 300);
  Timer? _restoreTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _hideSystemUi();
    SystemChrome.setSystemUIChangeCallback((systemOverlaysAreVisible) async {
      if (systemOverlaysAreVisible) {
        _scheduleRestore();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _scheduleRestore();
    }
  }

  @override
  void dispose() {
    _restoreTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    SystemChrome.setSystemUIChangeCallback(null);
    _showSystemUi();
    super.dispose();
  }

  void _scheduleRestore() {
    if (!_isAndroid) {
      return;
    }

    _restoreTimer?.cancel();
    _restoreTimer = Timer(_restoreDelay, _hideSystemUi);
  }

  Future<void> _hideSystemUi() async {
    if (!_isAndroid) {
      return;
    }

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  Future<void> _showSystemUi() async {
    if (!_isAndroid) {
      return;
    }

    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  bool get _isAndroid => defaultTargetPlatform == TargetPlatform.android;

  @override
  Widget build(BuildContext context) => widget.child;
}
