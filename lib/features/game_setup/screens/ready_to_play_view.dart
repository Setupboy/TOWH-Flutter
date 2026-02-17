import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/game_session.dart';
import '../../../core/utils/player_data.dart';
import '../../game/screens/game_view.dart';

class ReadyToPlayView extends StatefulWidget {
  final int playersCount;

  const ReadyToPlayView({super.key, required this.playersCount});

  @override
  State<ReadyToPlayView> createState() => _ReadyToPlayViewState();
}

class _ReadyToPlayViewState extends State<ReadyToPlayView> {
  static const Duration _bottomAnimationDuration = Duration(milliseconds: 320);

  bool _showReadyContent = false;
  bool _showBottomActions = false;
  bool _isBottomExitAnimating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        _showReadyContent = true;
        _showBottomActions = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final sessionPlayers = GameSession.inProgressPlayers;
    final firstPlayerName =
        (sessionPlayers == null || sessionPlayers.isEmpty)
            ? (kDemoPlayers.isEmpty ? 'Player 1' : kDemoPlayers.first.name)
            : sessionPlayers.first.name;

    return Scaffold(
      backgroundColor: kColorWhite50,
      appBar: AppBar(
        backgroundColor: kColorWhite50,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        centerTitle: false,
        title: const Text(
          'Ready To Play',
          style: TextStyle(
            fontSize: 24,
            fontFamily: kFontBaloo2,
            fontWeight: FontWeight.w600,
            color: kColorBlue900,
            height: 1.0,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: _showReadyContent
                      ? Column(
                          key: const ValueKey<String>('ready-content'),
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Game is ready',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 42,
                                fontFamily: kFontMPL,
                                fontWeight: FontWeight.w800,
                                color: kColorBlue900,
                                height: 1.0,
                              ),
                            ),
                            const SizedBox(height: 20),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text.rich(
                                TextSpan(
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: kFontMPL,
                                    fontWeight: FontWeight.w400,
                                    color: kColorBlue800,
                                    height: 1.86,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: 'All set, Give the phone to ',
                                    ),
                                    TextSpan(
                                      text: '[$firstPlayerName]',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: kFontMPL,
                                        fontWeight: FontWeight.w500,
                                        color: kColorBlue900,
                                        height: 1.86,
                                      ),
                                    ),
                                    const TextSpan(
                                      text:
                                          ' and Hit start\nwhen everyone is '
                                          'ready for the polling',
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(key: ValueKey<String>('ready-empty')),
                ),
              ),
              _buildAnimatedBottom(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: kColorGreen50,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: kColorGreen100),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 16,
                            color: kColorBlue800,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Quick guide:',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                              fontFamily: kFontMPL,
                              color: kColorBlue900,
                              height: 1.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'You will be given random colors to choose.',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: kFontMPL,
                          fontWeight: FontWeight.w400,
                          color: kColorBlue800,
                          height: 1.86,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildAnimatedBottom(
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _onStartGamePressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kColorYellow200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Start Game',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: kFontMPL,
                        fontWeight: FontWeight.w500,
                        color: kColorBlue900,
                        height: 1.46,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedBottom({required Widget child}) {
    return AnimatedSlide(
      duration: _bottomAnimationDuration,
      curve: Curves.easeInOut,
      offset: _showBottomActions ? Offset.zero : const Offset(0, 0.28),
      child: AnimatedOpacity(
        duration: _bottomAnimationDuration,
        curve: Curves.easeInOut,
        opacity: _showBottomActions ? 1 : 0,
        child: child,
      ),
    );
  }

  Future<void> _onStartGamePressed() async {
    if (_isBottomExitAnimating) return;
    setState(() {
      _isBottomExitAnimating = true;
      _showBottomActions = false;
    });
    await Future.delayed(_bottomAnimationDuration);
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => GameView(playersCount: widget.playersCount),
      ),
      (route) => false,
    );
  }
}
