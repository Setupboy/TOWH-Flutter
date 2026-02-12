import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/theme/color.dart';
import '../../../core/theme/font.dart';
import '../../../core/utils/player_data.dart';
import '../../game_setup/screens/new_game_view.dart';
import '../../home/screens/home_view.dart';

class ResultView extends StatefulWidget {
  final List<Color> resultColors;

  const ResultView({super.key, this.resultColors = const []});

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  static const List<String> _stickers = [
    'assets/images/result_page/sticker1.png',
    'assets/images/result_page/sticker2.png',
    'assets/images/result_page/sticker3.png',
    'assets/images/result_page/sticker4.png',
  ];

  late final String _selectedSticker;

  @override
  void initState() {
    super.initState();
    _selectedSticker = _stickers[Random().nextInt(_stickers.length)];
  }

  @override
  Widget build(BuildContext context) {
    final rowColors = widget.resultColors;

    return Scaffold(
      backgroundColor: kColorWithe50,
      appBar: AppBar(
        backgroundColor: kColorWithe50,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 16,
        title: const Text(
          'Match Result',
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
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          width: 175,
                          height: 150,
                          child: Image.asset(_selectedSticker),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Center(
                        child: Text(
                          'Alice Won the Vote',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 42,
                            fontFamily: kFontBaloo2,
                            fontWeight: FontWeight.w700,
                            color: kColorBlue900,
                            height: 1.14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Results',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: kFontMPL,
                          fontWeight: FontWeight.w500,
                          color: kColorBlue800,
                          height: 1.62,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...List.generate(rowColors.length, (index) {
                        const titles = ['Pizza', 'Steak', 'Felafel'];
                        final score = (rowColors.length - 1 - index).toString();
                        final player =
                            kDemoPlayers[index % kDemoPlayers.length];
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: index == rowColors.length - 1 ? 0 : 12,
                          ),
                          child: _ResultRow(
                            score: score,
                            scoreColor: rowColors[index],
                            title: titles[index % titles.length],
                            playerName: player.name,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: 184,
                      height: 45,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const Homeview()),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          'Finish',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: kFontMPL,
                            fontWeight: FontWeight.w500,
                            color: kColorBlue900,
                            height: 1.46,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 48,
                      width: 184,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const NewGameView(),
                            ),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: kColorYellow200,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Play Again',
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
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  final String score;
  final Color scoreColor;
  final String title;
  final String playerName;

  const _ResultRow({
    required this.score,
    required this.scoreColor,
    required this.title,
    required this.playerName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: scoreColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(
            child: Text(
              score,
              style: const TextStyle(
                fontSize: 48,
                fontFamily: kFontBaloo2,
                fontWeight: FontWeight.w600,
                color: kColorWithe100,
                height: 1.0,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 32,
                fontFamily: kFontMPL,
                fontWeight: FontWeight.w800,
                color: kColorBlue900,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              playerName,
              style: const TextStyle(
                fontSize: 24,
                fontFamily: kFontMPL,
                fontWeight: FontWeight.w400,
                color: kColorBlue800,
                height: 1.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
