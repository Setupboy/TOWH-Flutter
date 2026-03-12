import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:towh/core/models/game_document.dart';
import 'package:towh/core/navigation/game_flow.dart';
import 'package:towh/core/repositories/game_repository.dart';
import 'package:towh/core/theme/app_colors.dart';
import 'package:towh/core/theme/app_fonts.dart';
import 'package:towh/core/utils/player_data.dart';
import 'package:towh/features/game/screens/game_view.dart';
import 'package:towh/features/history/screens/history_view.dart';
import 'package:towh/features/home/widgets/game_box.dart';
import 'package:towh/features/home/widgets/nav_bar_item.dart';
import 'package:towh/features/home/widgets/player_chip.dart';

import '../../game_setup/screens/new_game_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GameRepository _repository = GameRepository.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite50,
      appBar: AppBar(
        backgroundColor: kColorWhite50,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 16,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icons/tow.svg',
              width: 36,
              height: 36,
              colorFilter: const ColorFilter.mode(
                kColorYellow200,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'To W?',
              style: TextStyle(
                fontFamily: 'Baloo2',
                fontSize: 24,
                fontWeight: FontWeight.w600,
                height: 1,
                color: kColorBlue900,
              ),
            ),
          ],
        ),
        foregroundColor: kColorBlue900,
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              _buildWelcomeCard(context),
              const SizedBox(height: 24),
              _buildInProgressSection(),
              const SizedBox(height: 24),
              _buildCompletedSection(
                title: 'Repeat game',
                emptyText: 'Completed games will show here.',
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        height: 64,
        decoration: BoxDecoration(
          color: kColorWhite100,
          borderRadius: BorderRadius.circular(24),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Row(
            children: [
              Expanded(
                child: NavBarItem(
                  icon: FluentIcons.xbox_controller_24_regular,
                  label: 'Play',
                  isSelected: true,
                  onTap: () {},
                ),
              ),
              Expanded(
                child: NavBarItem(
                  icon: FluentIcons.history_24_regular,
                  label: 'History',
                  isSelected: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const HistoryView()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    return SizedBox(
      width: 380,
      height: 226,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome',
            style: TextStyle(
              fontFamily: 'Baloo2',
              fontSize: 42,
              fontWeight: FontWeight.w700,
              height: 1.14,
              color: kColorBlue900,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Create a new game with friends present',
            style: TextStyle(
              fontFamily: kFontMPL,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.625,
              color: kColorBlue800,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NewGameView()),
              );
            },
            child: Container(
              width: 380,
              height: 124,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kColorYellow200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '+ New Game',
                style: TextStyle(
                  fontFamily: kFontMPL,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: kColorBlue900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInProgressSection() {
    return StreamBuilder<List<GameDocument>>(
      stream: _repository.getInProgressGames(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildSectionError('Failed to load in-progress games.');
        }
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final games = snapshot.data!;
        if (games.isEmpty) {
          return const SizedBox.shrink();
        }

        return _buildSectionGroup(
          title: 'In progress game',
          cards: games.take(2).map(_buildInProgressCard).toList(),
        );
      },
    );
  }

  Widget _buildCompletedSection({
    required String title,
    required String emptyText,
  }) {
    return StreamBuilder<List<GameDocument>>(
      stream: _repository.getCompletedGames(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildSectionError('Failed to load completed games.');
        }
        if (!snapshot.hasData) {
          return _buildSectionEmpty(title: title, text: 'Loading games...');
        }

        final games = snapshot.data!;
        if (games.isEmpty) {
          return _buildSectionEmpty(title: title, text: emptyText);
        }

        return _buildSectionGroup(
          title: title,
          cards: games
              .take(2)
              .map((game) => _buildCompletedCard(game))
              .toList(),
        );
      },
    );
  }

  Widget _buildInProgressCard(GameDocument game) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: GameBox(
        gameTitle: game.activityName,
        detailLabel: 'Stage:',
        detailValue: _stageLabel(game.stage),
        players: _playerChips(game),
        onTap: () async {
          final gameToOpen = game.stage == 'players_answers'
              ? await _repository.restartPlayerAnswers(game.id)
              : game;
          if (!mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => buildGameStageView(gameToOpen)),
          );
        },
      ),
    );
  }

  Widget _buildCompletedCard(GameDocument game) {
    return GameBox(
      gameTitle: game.activityName,
      detailLabel: game.isTie ? '' : 'Winner:',
      detailValue: game.isTie ? "It's a tie" : game.winnerAnswer,
      secondaryDetailLabel: game.isTie ? null : 'By:',
      secondaryDetailValue: game.isTie ? null : game.winnerPlayerName,
      players: _playerChips(game),
      onTap: () async {
        final repeatedGameId = await _repository.repeatGame(game);
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => GameView(gameId: repeatedGameId)),
        );
      },
    );
  }

  List<Widget> _playerChips(GameDocument game) {
    return List<Widget>.generate(game.players.length, (int index) {
      final player = game.players[index];
      return PlayerChip(
        name: player.name,
        backgroundColor: avatarColorForIndex(index),
      );
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

  Widget _buildSectionEmpty({required String title, required String text}) {
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
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: kColorWhite100,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: kFontMPL,
              fontSize: 14,
              color: kColorBlue800,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionError(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kColorWhite100,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: kFontMPL,
          fontSize: 14,
          color: kColorRed600,
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
}
