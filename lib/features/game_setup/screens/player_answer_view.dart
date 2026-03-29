import 'package:flutter/material.dart';

import 'package:towh/core/models/game_document.dart';
import 'package:towh/core/repositories/game_repository.dart';
import 'package:towh/core/theme/app_colors.dart';
import 'package:towh/core/theme/app_fonts.dart';
import 'package:towh/core/utils/player_data.dart';
import 'package:towh/core/widgets/game_fullscreen_scope.dart';

import 'ready_to_play_view.dart';

class PlayerAnswerView extends StatefulWidget {
  const PlayerAnswerView({super.key, required this.gameId});

  final String gameId;

  @override
  State<PlayerAnswerView> createState() => _PlayerAnswerViewState();
}

class _PlayerAnswerViewState extends State<PlayerAnswerView> {
  final GameRepository _repository = GameRepository.instance;
  final TextEditingController _answerController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GameDocument>(
      stream: _repository.watchGame(widget.gameId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final game = snapshot.data!;
        final player = game.players[game.currentPlayerIndex];

        return GameFullscreenScope(
          child: Scaffold(
            backgroundColor: kColorWhite50,
            appBar: AppBar(
              backgroundColor: kColorWhite50,
              elevation: 0,
              foregroundColor: kColorBlue900,
              surfaceTintColor: Colors.transparent,
              title: const Text(
                'Player Answers',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: kFontBaloo2,
                  fontWeight: FontWeight.w600,
                  color: kColorBlue900,
                ),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: avatarColorFromName(player.name),
                      child: Text(
                        initialsFromName(player.name),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: kColorWhite100,
                          fontFamily: kFontMPL,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      player.name,
                      style: const TextStyle(
                        fontSize: 32,
                        fontFamily: kFontBaloo2,
                        fontWeight: FontWeight.w700,
                        color: kColorBlue900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Activity: ${game.activityName}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: kFontMPL,
                        color: kColorBlue800,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: kColorWhite100,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Your answer',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: kFontMPL,
                              fontWeight: FontWeight.w500,
                              color: kColorBlue900,
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _answerController,
                            decoration: InputDecoration(
                              hintText: 'Write Answer',
                              filled: true,
                              fillColor: kColorWhite50,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: kColorPink50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Keep the answer private before passing the phone.',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: kFontMPL,
                          color: kColorRed600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _isSaving ? null : () => _onSubmit(game),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kColorYellow200,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isSaving
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                game.currentPlayerIndex ==
                                        game.players.length - 1
                                    ? 'Finish Answers'
                                    : 'Confirm and Next Player',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: kFontMPL,
                                  fontWeight: FontWeight.w500,
                                  color: kColorBlue900,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _onSubmit(GameDocument game) async {
    final answer = _answerController.text.trim();
    if (answer.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Answer is required.')));
      return;
    }

    setState(() => _isSaving = true);
    await _repository.savePlayerAnswer(
      gameId: widget.gameId,
      playerIndex: game.currentPlayerIndex,
      answer: answer,
    );
    _answerController.clear();

    if (!mounted) {
      return;
    }

    if (game.currentPlayerIndex == game.players.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ReadyToPlayView(gameId: widget.gameId),
        ),
      );
    } else {
      setState(() => _isSaving = false);
    }
  }
}
