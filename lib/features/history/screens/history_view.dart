import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:towh/core/models/game_document.dart';
import 'package:towh/core/navigation/game_flow.dart';
import 'package:towh/core/repositories/game_repository.dart';
import 'package:towh/core/theme/app_colors.dart';
import 'package:towh/core/theme/app_fonts.dart';
import 'package:towh/core/utils/player_data.dart';
import 'package:towh/features/game/screens/game_view.dart';
import 'package:towh/features/game_setup/screens/new_game_view.dart';
import 'package:towh/features/home/screens/home_view.dart';
import 'package:towh/features/home/widgets/game_box.dart';
import 'package:towh/features/home/widgets/nav_bar_item.dart';
import 'package:towh/features/home/widgets/player_chip.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  static const int _completedGamesBatchSize = 5;
  static const double _loadMoreThreshold = 300;

  static final Uri _privacyUri = Uri.parse(
    'https://sites.google.com/view/towh-privacy/home',
  );

  final ScrollController _scrollController = ScrollController();
  int _visibleCompletedGames = _completedGamesBatchSize;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repository = GameRepository.instance;
    final bottomInset = MediaQuery.of(context).padding.bottom;
    const bottomNavHeight = 64.0;
    const bottomNavVerticalMargin = 16.0;
    final scrollBottomPadding =
        bottomInset + bottomNavHeight + bottomNavVerticalMargin + 16;

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
        actions: [
          IconButton(
            tooltip: 'Privacy policy',
            onPressed: _openPrivacyPolicy,
            icon: const Icon(Icons.help_outline_rounded),
          ),
        ],
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
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      controller: _scrollController,
                      padding: EdgeInsets.only(bottom: scrollBottomPadding),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight - scrollBottomPadding,
                        ),
                        child: _buildCompletedSection(
                          context,
                          repository,
                          addTopSpacing: false,
                        ),
                      ),
                    );
                  },
                );
              }

              return SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.only(bottom: scrollBottomPadding),
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
                            primaryActionLabel: 'Continue',
                            onPrimaryAction: () async {
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
                            secondaryActionLabel: 'Delete',
                            onSecondaryAction: () async {
                              final shouldDelete = await _showDeleteSheet(
                                context,
                              );
                              if (shouldDelete == true) {
                                await repository.deleteGame(game.id);
                              }
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
      bottomNavigationBar: SafeArea(
        top: false,
        minimum: const EdgeInsets.only(bottom: 8),
        child: Container(
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
        return 'Voting';
      case 'voting':
        return 'Voting';
      case 'completed':
        return 'Completed';
      default:
        return stage;
    }
  }

  Future<void> _openPrivacyPolicy() async {
    await launchUrl(_privacyUri, mode: LaunchMode.externalApplication);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }
    final position = _scrollController.position;
    if (position.pixels <
        position.maxScrollExtent - _loadMoreThreshold) {
      return;
    }

    setState(() {
      _visibleCompletedGames += _completedGamesBatchSize;
    });
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
        final visibleGames = games.take(_visibleCompletedGames).toList();
        final hasMoreGames = visibleGames.length < games.length;
        if (games.isEmpty) {
          if (!addTopSpacing) {
            return _buildEmptyState(context);
          }

          return const SizedBox.shrink();
        }

        return Padding(
          padding: EdgeInsets.only(top: addTopSpacing ? 24 : 0),
          child: _buildSectionGroup(
            title: 'Game History',
            cards: [
              ...visibleGames.map((game) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: GameBox(
                  gameTitle: game.activityName,
                  detailLabel: game.isTie ? '' : 'Winner:',
                  detailValue: game.isTie ? "It's a tie" : game.winnerChoice,
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => buildGameStageView(game),
                      ),
                    );
                  },
                  primaryActionLabel: 'Repeat Game',
                  onPrimaryAction: () async {
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
              }),
              if (hasMoreGames)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 380,
        height: 125,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: kColorWhite100,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'You have not played any game yet',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: kFontMPL,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1,
                  color: kColorBlue900,
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 348,
                  height: 48,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const NewGameView()),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      decoration: BoxDecoration(
                        color: kColorYellow200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        '+New Game',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: kFontMPL,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 1.46,
                          color: kColorBlue900,
                        ),
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

  Future<bool?> _showDeleteSheet(BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
            32,
            12,
            32,
            MediaQuery.of(context).padding.bottom + 12,
          ),
          decoration: const BoxDecoration(
            color: kColorWhite50,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 67,
                  height: 3,
                  decoration: BoxDecoration(
                    color: kColorBlue100,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Delete Game',
                style: TextStyle(
                  fontFamily: 'Baloo2',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: kColorBlue900,
                  height: 1,
                ),
              ),
              const SizedBox(height: 24),
              const SizedBox(
                width: double.infinity,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Are you sure you want to cancel the game?',
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: kFontMPL,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: kColorBlue800,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 34,
                      width: 176,
                      child: TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        style: TextButton.styleFrom(
                          foregroundColor: kColorBlue900,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontFamily: kFontMPL,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: kColorBlue900,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 34,
                      width: 176,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: kColorYellow200,
                          foregroundColor: kColorBlue900,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Delete',
                          style: TextStyle(
                            fontFamily: kFontMPL,
                            fontSize: 12,
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
        );
      },
    );
  }
}
