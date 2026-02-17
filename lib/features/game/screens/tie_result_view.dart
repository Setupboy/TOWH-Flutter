import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/game_session.dart';
import '../../game_setup/screens/ready_to_play_view.dart';
import '../models/vote_result_item.dart';

class TieResultView extends StatefulWidget {
  final List<VoteResultItem> voteResults;

  const TieResultView({super.key, this.voteResults = const []});

  @override
  State<TieResultView> createState() => _TieResultViewState();
}

class _TieResultViewState extends State<TieResultView> {
  static const List<String> _stickers = [
    'assets/images/result_page/sticker1.png',
    'assets/images/result_page/sticker2.png',
    'assets/images/result_page/sticker3.png',
    'assets/images/result_page/sticker4.png',
  ];

  late final String _selectedSticker = _stickers[Random().nextInt(_stickers.length)];

  @override
  Widget build(BuildContext context) {
    final playersCount = GameSession.inProgressPlayers?.length ?? 3;

    return Scaffold(
      backgroundColor: kColorWhite50,
      appBar: AppBar(
        backgroundColor: kColorWhite50,
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
                          "It's A Tie!\nRepeat The Game",
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
                      ...List.generate(widget.voteResults.length, (index) {
                        final result = widget.voteResults[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: index == widget.voteResults.length - 1
                                ? 0
                                : 12,
                          ),
                          child: _ResultRow(
                            voteCount: result.voteCount,
                            scoreColor: result.color,
                            title: result.choiceTitle,
                            playerName: result.playerName,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ReadyToPlayView(playersCount: playersCount),
                      ),
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
                    'Try Again',
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

class _ResultRow extends StatelessWidget {
  final int voteCount;
  final Color scoreColor;
  final String title;
  final String playerName;

  const _ResultRow({
    required this.voteCount,
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
              voteCount.toString(),
              style: const TextStyle(
                fontSize: 48,
                fontFamily: kFontBaloo2,
                fontWeight: FontWeight.w600,
                color: kColorWhite100,
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
