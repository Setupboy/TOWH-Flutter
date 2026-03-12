import 'package:flutter/material.dart';

import 'package:towh/core/models/game_document.dart';
import 'package:towh/core/repositories/game_repository.dart';
import 'package:towh/core/theme/app_colors.dart';
import 'package:towh/core/theme/app_fonts.dart';

import 'player_answer_view.dart';

class PlayerNamesView extends StatefulWidget {
  const PlayerNamesView({super.key, required this.gameId});

  final String gameId;

  @override
  State<PlayerNamesView> createState() => _PlayerNamesViewState();
}

class _PlayerNamesViewState extends State<PlayerNamesView> {
  final GameRepository _repository = GameRepository.instance;
  final List<TextEditingController> _controllers = <TextEditingController>[];

  bool _isSaving = false;

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
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
        _syncControllers(game);

        return Scaffold(
          backgroundColor: kColorWhite50,
          appBar: AppBar(
            backgroundColor: kColorWhite50,
            elevation: 0,
            foregroundColor: kColorBlue900,
            surfaceTintColor: Colors.transparent,
            title: const Text(
              'Player Names',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Enter all player names before answers begin.',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: kFontMPL,
                      color: kColorBlue800,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.separated(
                      itemCount: game.playersCount,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return TextField(
                          controller: _controllers[index],
                          decoration: InputDecoration(
                            labelText: 'Player ${index + 1}',
                            filled: true,
                            fillColor: kColorWhite100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _isSaving ? null : () => _onConfirm(game),
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
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text(
                              'Confirm Players',
                              style: TextStyle(
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
        );
      },
    );
  }

  void _syncControllers(GameDocument game) {
    if (_controllers.length == game.playersCount) {
      return;
    }
    for (final controller in _controllers) {
      controller.dispose();
    }
    _controllers
      ..clear()
      ..addAll(
        List<TextEditingController>.generate(game.playersCount, (int index) {
          final existingName = index < game.players.length
              ? game.players[index].name
              : '';
          return TextEditingController(text: existingName);
        }),
      );
  }

  Future<void> _onConfirm(GameDocument game) async {
    final playerNames = _controllers
        .map((controller) => controller.text.trim())
        .toList();
    if (playerNames.any((name) => name.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Every player name is required.')),
      );
      return;
    }

    setState(() => _isSaving = true);
    await _repository.savePlayerNames(widget.gameId, playerNames);
    if (!mounted) {
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => PlayerAnswerView(gameId: widget.gameId),
      ),
    );
  }
}
