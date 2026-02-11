import 'package:flutter/material.dart';

import '../../../core/theme/color.dart';
import '../../../core/theme/font.dart';
import '../../game/screens/game_view.dart';

class ReadyToPlayView extends StatefulWidget {
  final int playersCount;

  const ReadyToPlayView({super.key, required this.playersCount});

  @override
  State<ReadyToPlayView> createState() => _ReadyToPlayViewState();
}

class _ReadyToPlayViewState extends State<ReadyToPlayView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWithe50,
      appBar: AppBar(
        backgroundColor: kColorWithe50,
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
                child: Column(
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
                          children: const [
                            TextSpan(text: 'All set, Give the phone to '),
                            TextSpan(
                              text: '[Player 1]',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: kFontMPL,
                                fontWeight: FontWeight.w500,
                                color: kColorBlue900,
                                height: 1.86,
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' and Hit start\nwhen everyone is ready for '
                                  'the polling',
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
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
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            GameView(playersCount: widget.playersCount),
                      ),
                      (route) => false,
                    );
                  },
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
            ],
          ),
        ),
      ),
    );
  }
}
