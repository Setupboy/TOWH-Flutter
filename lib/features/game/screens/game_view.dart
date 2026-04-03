import 'package:flutter/material.dart';

import '../../../core/models/game_document.dart';
import '../../../core/repositories/game_repository.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/player_data.dart';
import '../../../core/widgets/game_fullscreen_scope.dart';
import '../models/vote_result_item.dart';
import 'result_view.dart';
import 'tie_result_view.dart';

class GameView extends StatefulWidget {
  final String gameId;

  const GameView({super.key, required this.gameId});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  static const double _swipeVelocityThreshold = 300;

  final GameRepository _repository = GameRepository.instance;
  final ScrollController _scrollController = ScrollController();
  int? _selectedColorIndex;
  String? _selectionErrorText;
  bool _showPageContent = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() => _showPageContent = true);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
        final choiceColors = _buildChoiceColors(game);
        final currentPlayer = game.players[game.currentVotingTurnIndex];

        return GameFullscreenScope(
          child: Scaffold(
            backgroundColor: kColorWhite50,
            appBar: AppBar(
              foregroundColor: kColorBlue900,
              surfaceTintColor: Colors.transparent,
              backgroundColor: kColorWhite50,
              elevation: 0,
              automaticallyImplyLeading: false,
              titleSpacing: 16,
              title: const Text(
                'Play',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: kFontBaloo2,
                  fontWeight: FontWeight.w600,
                  color: kColorBlue900,
                  height: 1,
                ),
              ),
            ),
            body: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onHorizontalDragEnd: (details) =>
                  _onHorizontalDragEnd(details, game),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: _showPageContent
                    ? SafeArea(
                        key: const ValueKey<String>('game-content'),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  controller: _scrollController,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 28,
                                            backgroundColor:
                                                avatarColorFromName(
                                                  currentPlayer.name,
                                                ),
                                            child: Text(
                                              initialsFromName(
                                                currentPlayer.name,
                                              ),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color: kColorWhite100,
                                                fontFamily: kFontMPL,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            currentPlayer.name,
                                            style: const TextStyle(
                                              fontSize: 28,
                                              fontFamily: kFontMPL,
                                              fontWeight: FontWeight.w800,
                                              color: kColorBlue900,
                                              height: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 24),
                                      const Text(
                                        textAlign: TextAlign.center,
                                        'Your Turn to\nchoose',
                                        style: TextStyle(
                                          fontSize: 42,
                                          fontFamily: kFontBaloo2,
                                          fontWeight: FontWeight.w700,
                                          color: kColorBlue900,
                                          height: 1.14,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      LayoutBuilder(
                                        builder: (context, constraints) {
                                          final double itemWidth =
                                              (constraints.maxWidth - 12) / 2;
                                          return Wrap(
                                            spacing: 12,
                                            runSpacing: 12,
                                            children: List.generate(
                                              choiceColors.length,
                                              (index) {
                                                final choice =
                                                    choiceColors[index];
                                                final bool isSelected =
                                                    _selectedColorIndex ==
                                                    index;
                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _selectedColorIndex =
                                                          index;
                                                      _selectionErrorText =
                                                          null;
                                                    });
                                                  },
                                                  child: SizedBox(
                                                    width: itemWidth,
                                                    child: _buildColorCard(
                                                      choice,
                                                      isSelected,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text.rich(
                                TextSpan(
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: kFontMPL,
                                    fontWeight: FontWeight.w400,
                                    color: kColorRed600,
                                    height: 1.86,
                                  ),
                                  children: [
                                    const TextSpan(text: 'Choose a color '),
                                    TextSpan(
                                      text: currentPlayer.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              if (_selectionErrorText != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  _selectionErrorText!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: kFontMPL,
                                    fontWeight: FontWeight.w400,
                                    color: kColorRed600,
                                    height: 1.4,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: () => _onContinuePressed(game),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kColorYellow200,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: const Text(
                                    'Continue',
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
                      )
                    : const SizedBox(key: ValueKey<String>('game-empty')),
              ),
            ),
          ),
        );
      },
    );
  }

  List<_ChoiceColor> _buildChoiceColors(GameDocument game) {
    return game.players.map((player) {
      return _ChoiceColor(
        name: _displayColorName(player.selectedColor),
        storageName: player.selectedColor,
        color: _colorForStorageName(player.selectedColor),
      );
    }).toList();
  }

  Future<void> _onContinuePressed(GameDocument game) async {
    if (_selectedColorIndex == null) {
      setState(() => _selectionErrorText = 'Please select one color');
      return;
    }

    final selectedColor = game.players[_selectedColorIndex!].selectedColor;
    await _repository.saveVoteSelection(
      gameId: widget.gameId,
      colorName: selectedColor,
    );

    if (!mounted) return;

    if (game.currentVotingTurnIndex >= game.players.length - 1) {
      final updatedGame = await _repository.continueGame(widget.gameId);
      if (!mounted) return;
      final voteResults = _buildVoteResults(updatedGame);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => updatedGame.isTie
              ? TieResultView(gameId: widget.gameId, voteResults: voteResults)
              : ResultView(gameId: widget.gameId, voteResults: voteResults),
        ),
      );
      return;
    }

    setState(() {
      _selectedColorIndex = null;
      _selectionErrorText = null;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details, GameDocument game) {
    final velocity = details.primaryVelocity ?? 0;
    if (velocity.abs() < _swipeVelocityThreshold) return;
    if (velocity < 0) {
      _onContinuePressed(game);
      return;
    }
    Navigator.of(context).pop();
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
            voteCount: game.voteCountForPlayer(player),
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

  Widget _buildColorCard(_ChoiceColor choice, bool isSelected) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: 182,
          height: 167,
          decoration: BoxDecoration(
            color: isSelected ? kColorYellow200 : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.all(2),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: choice.color,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              if (isSelected)
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: kColorWhite100,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: const BoxDecoration(
                          color: kColorYellow200,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          size: 20,
                          color: kColorWhite100,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        Positioned(
          bottom: 2,
          child: Container(
            width: 134,
            height: 22,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: const BoxDecoration(
              color: kColorWhite100,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Center(
              child: Text(
                choice.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: kFontMPL,
                  fontWeight: FontWeight.w500,
                  color: kColorBlue900,
                  height: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _displayColorName(String value) {
    if (value.isEmpty) return 'Color';
    return value
        .split('_')
        .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
        .join(' ');
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
      case 'lime':
        return const Color(0xFF84CC16);
      case 'magenta':
        return const Color(0xFFD946EF);
      case 'brown':
        return const Color(0xFF8D6E63);
      case 'navy':
        return const Color(0xFF1E3A8A);
      case 'mint':
        return const Color(0xFF34D399);
      case 'amber':
        return const Color(0xFFF59E0B);
      case 'coral':
        return const Color(0xFFFF7F50);
      case 'sky':
        return const Color(0xFF38BDF8);
      case 'olive':
        return const Color(0xFF6B8E23);
      case 'slate':
        return const Color(0xFF64748B);
      default:
        return const Color(0xFF9C27B0);
    }
  }
}

class _ChoiceColor {
  final String name;
  final String storageName;
  final Color color;

  const _ChoiceColor({
    required this.name,
    required this.storageName,
    required this.color,
  });
}
