import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:towh/core/models/game_document.dart';
import 'package:towh/core/navigation/game_flow.dart';
import 'package:towh/core/repositories/game_repository.dart';
import 'package:towh/core/theme/app_colors.dart';
import 'package:towh/core/theme/app_fonts.dart';
import 'package:towh/core/utils/player_data.dart';
import 'package:towh/features/game/screens/game_view.dart';
import 'package:towh/features/home/screens/home_view.dart';
import 'package:towh/features/home/widgets/game_box.dart';
import 'package:towh/features/home/widgets/nav_bar_item.dart';
import 'package:towh/features/home/widgets/player_chip.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = GameRepository.instance;

    return Scaffold(
      backgroundColor: kColorWhite50,
      appBar: AppBar(
        backgroundColor: kColorWhite50,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        foregroundColor: kColorBlue900,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'History',
          style: TextStyle(
            fontFamily: 'Baloo2',
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: kColorBlue900,
            height: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: StreamBuilder<List<GameDocument>>(
            stream: repository.getInProgressGames(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Failed to load in-progress games.');
              }
              if (!snapshot.hasData) {
                return const Text(
                  'Loading games...',
                  style: TextStyle(fontFamily: kFontMPL, color: kColorBlue800),
                );
              }

              final games = snapshot.data!;
              if (games.isEmpty) {
                return _buildCompletedSection(
                  context,
                  repository,
                  addTopSpacing: false,
                );
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    _buildSectionGroup(
                      title: 'In progress game',
                      cards: games.map((game) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: GameBox(
                            gameTitle: game.activityName,
                            detailLabel: 'Stage:',
                            detailValue: _stageLabel(game.stage),
                            players: List<Widget>.generate(
                              game.players.length,
                              (i) {
                                final player = game.players[i];
                                return PlayerChip(
                                  name: player.name,
                                  backgroundColor: avatarColorForIndex(i),
                                );
                              },
                            ),
                            onTap: () async {
                              final gameToOpen = game.stage == 'players_answers'
                                  ? await repository.restartPlayerAnswers(
                                      game.id,
                                    )
                                  : game;
                              if (!context.mounted) return;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      buildGameStageView(gameToOpen),
                                ),
                              );
                            },
                          ),
                        );
                      }).toList(),
                    ),
                    _buildCompletedSection(
                      context,
                      repository,
                      addTopSpacing: true,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        height: 64,
        decoration: BoxDecoration(
          color: kColorWhite100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Row(
            children: [
              Expanded(
                child: NavBarItem(
                  icon: FluentIcons.xbox_controller_24_regular,
                  label: 'Play',
                  isSelected: false,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeView()),
                    );
                  },
                ),
              ),
              Expanded(
                child: NavBarItem(
                  icon: FluentIcons.history_24_regular,
                  label: 'History',
                  isSelected: true,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _stageLabel(String stage) {
    switch (stage) {
      case 'players_names':
        return 'Player Names';
      case 'players_answers':
        return 'Player Answers';
      case 'ready_to_play':
        return 'Ready To Play';
      case 'voting':
        return 'Voting';
      case 'completed':
        return 'Completed';
      default:
        return stage;
    }
  }

  Widget _buildSectionGroup({
    required String title,
    required List<Widget> cards,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: kFontMPL,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: kColorBlue800,
          ),
        ),
        const SizedBox(height: 8),
        ...cards,
      ],
    );
  }

  Widget _buildCompletedSection(
    BuildContext context,
    GameRepository repository, {
    required bool addTopSpacing,
  }) {
    return StreamBuilder<List<GameDocument>>(
      stream: repository.getCompletedGames(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Failed to load history.'));
        }
        if (!snapshot.hasData) {
          return const Center(
            child: Text(
              'Loading games...',
              style: TextStyle(fontFamily: kFontMPL, color: kColorBlue800),
            ),
          );
        }

        final games = snapshot.data!;
        if (games.isEmpty) {
          if (!addTopSpacing) {
            return const Center(
              child: Text(
                "You haven't play any games yet!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: kFontMPL,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  height: 1.625,
                  color: kColorBlue800,
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        }

        return Padding(
          padding: EdgeInsets.only(top: addTopSpacing ? 24 : 0),
          child: _buildSectionGroup(
            title: 'Repeat game',
            cards: games.map((game) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: GameBox(
                  gameTitle: game.activityName,
                  detailLabel: game.isTie ? '' : 'Winner:',
                  detailValue: game.isTie ? "It's a tie" : game.winnerAnswer,
                  secondaryDetailLabel: game.isTie ? null : 'By:',
                  secondaryDetailValue: game.isTie
                      ? null
                      : game.winnerPlayerName,
                  players: List<Widget>.generate(game.players.length, (i) {
                    final player = game.players[i];
                    return PlayerChip(
                      name: player.name,
                      backgroundColor: avatarColorForIndex(i),
                    );
                  }),
                  onTap: () async {
                    final repeatedGameId = await repository.repeatGame(game);
                    if (!context.mounted) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GameView(gameId: repeatedGameId),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
