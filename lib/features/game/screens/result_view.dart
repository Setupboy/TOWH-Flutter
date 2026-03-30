import 'dart:math';

import 'package:flutter/material.dart';
import 'package:towh/core/ads/ad_service.dart';

import '../../../core/models/game_document.dart';
import '../../../core/repositories/game_repository.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/widgets/game_fullscreen_scope.dart';
import '../../home/screens/home_view.dart';
import 'game_view.dart';
import '../models/vote_result_item.dart';

class ResultView extends StatefulWidget {
  final String gameId;
  final List<VoteResultItem> voteResults;

  const ResultView({
    super.key,
    required this.gameId,
    this.voteResults = const [],
  });

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

  final GameRepository _repository = GameRepository.instance;
  late final String _selectedSticker;
  bool _showPageContent = false;

  @override
  void initState() {
    super.initState();
    _selectedSticker = _stickers[Random().nextInt(_stickers.length)];
    AdService.instance.preloadInterstitial();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() => _showPageContent = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GameDocument>(
      stream: _repository.watchGame(widget.gameId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(backgroundColor: kColorWhite50);
        }

        final game = snapshot.data!;
        final sortedResults = widget.voteResults.isNotEmpty
            ? widget.voteResults
            : _buildVoteResults(game);

        final winnerTitle = sortedResults.isEmpty
            ? 'No votes yet'
            : '${sortedResults.first.playerName} Won the Vote';

        return GameFullscreenScope(
          child: Scaffold(
            backgroundColor: kColorWhite50,
            appBar: AppBar(
              backgroundColor: kColorWhite50,
              elevation: 0,
              automaticallyImplyLeading: false,
              surfaceTintColor: Colors.transparent,
              titleSpacing: 16,
              title: const Text(
                'Match Result',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: kFontBaloo2,
                  fontWeight: FontWeight.w600,
                  color: kColorBlue900,
                  height: 1,
                ),
              ),
            ),
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: _showPageContent
                  ? SafeArea(
                      key: const ValueKey<String>('result-content'),
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
                                    Center(
                                      child: Text(
                                        winnerTitle,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
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
                                    ...List.generate(sortedResults.length, (
                                      index,
                                    ) {
                                      final result = sortedResults[index];
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          bottom:
                                              index == sortedResults.length - 1
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
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: 184,
                                    height: 45,
                                    child: TextButton(
                                      onPressed: () {
                                        AdService.instance.showInterstitialThen(
                                          onComplete: () {
                                            if (!context.mounted) return;
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    const HomeView(),
                                              ),
                                              (route) => false,
                                            );
                                          },
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
                                  child: SizedBox(
                                    height: 48,
                                    width: 184,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        final repeatedGameId = await _repository
                                            .repeatGame(game);
                                        if (!context.mounted) return;
                                        AdService.instance.showInterstitialThen(
                                          onComplete: () {
                                            if (!context.mounted) return;
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => GameView(
                                                  gameId: repeatedGameId,
                                                ),
                                              ),
                                              (route) => false,
                                            );
                                          },
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: kColorYellow200,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
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
                    )
                  : const SizedBox(key: ValueKey<String>('result-empty')),
            ),
          ),
        );
      },
    );
  }

  List<VoteResultItem> _buildVoteResults(GameDocument game) {
    final results = <VoteResultItem>[];
    for (int i = 0; i < game.players.length; i++) {
      final player = game.players[i];
      results.add(
        VoteResultItem(
          choiceTitle: player.answer,
          playerName: player.name,
          color: _colorForStorageName(player.selectedColor),
          voteCount: game.results[player.answer] ?? 0,
          order: i,
        ),
      );
    }
    results.sort((a, b) {
      final byVotes = b.voteCount.compareTo(a.voteCount);
      if (byVotes != 0) return byVotes;
      return a.order.compareTo(b.order);
    });
    return results;
  }

  Color _colorForStorageName(String name) {
    switch (name) {
      case 'green':
        return const Color(0xFF70B80C);
      case 'blue':
        return const Color(0xFF3277D1);
      case 'purple':
        return const Color(0xFF9500F2);
      case 'orange':
        return const Color(0xFFF38B25);
      case 'red':
        return const Color(0xFFE54B4B);
      case 'pink':
        return const Color(0xFFE45FB4);
      case 'yellow':
        return const Color(0xFFF1B51C);
      case 'teal':
        return const Color(0xFF009688);
      case 'cyan':
        return const Color(0xFF00BCD4);
      case 'indigo':
        return const Color(0xFF3F51B5);
      default:
        return const Color(0xFF9C27B0);
    }
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
                height: 1,
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
                height: 1,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              playerName,
              style: const TextStyle(
                fontSize: 24,
                fontFamily: kFontMPL,
                fontWeight: FontWeight.w400,
                color: kColorBlue800,
                height: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
