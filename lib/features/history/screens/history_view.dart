import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:towh/core/theme/app_colors.dart';
import 'package:towh/core/utils/game_session.dart';
import 'package:towh/core/utils/player_data.dart';
import 'package:towh/features/home/screens/home_view.dart';
import 'package:towh/features/home/widgets/game_box.dart';
import 'package:towh/features/home/widgets/nav_bar_item.dart';
import 'package:towh/features/home/widgets/player_chip.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
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
  Widget build(BuildContext context) {
    final sessionPlayers = GameSession.inProgressPlayers;
    final inProgressPlayers =
        (sessionPlayers == null || sessionPlayers.isEmpty)
            ? kDemoPlayers
            : sessionPlayers;
    final repeatCampingPlayers = const [
      PlayerData(name: 'Alice', imageUrl: ''),
      PlayerData(name: 'Stephen', imageUrl: ''),
      PlayerData(name: 'Samuel', imageUrl: ''),
      PlayerData(name: 'Tony', imageUrl: ''),
      PlayerData(name: 'Mendy', imageUrl: ''),
    ];

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
            height: 1.0,
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
                key: const ValueKey<String>('history-content'),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        GameBox(
                          title: 'In progress game',
                          gameTitle:
                              GameSession.inProgressActivityName ??
                              'Restaurant Night',
                          players: List.generate(inProgressPlayers.length, (
                            index,
                          ) {
                            final player = inProgressPlayers[index];
                            return PlayerChip(
                              name: player.name,
                              backgroundColor: avatarColorForIndex(index),
                            );
                          }),
                        ),
                        const SizedBox(height: 24),
                        GameBox(
                          title: 'Repeat game',
                          gameTitle: 'Cafe Morning',
                          players: List.generate(kDemoPlayers.length, (index) {
                            final player = kDemoPlayers[index];
                            return PlayerChip(
                              name: player.name,
                              backgroundColor: avatarColorForIndex(index),
                            );
                          }),
                        ),
                        const SizedBox(height: 8),
                        GameBox(
                          title: 'Repeat game',
                          gameTitle: 'Camping',
                          players: List.generate(
                            repeatCampingPlayers.length,
                            (index) {
                              final player = repeatCampingPlayers[index];
                              return PlayerChip(
                                name: player.name,
                                backgroundColor: avatarColorForIndex(index),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox(key: ValueKey<String>('history-empty')),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        height: 64,
        width: 380,
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
              Expanded(
                child: NavBarItem(
                  icon: FluentIcons.person_circle_24_regular,
                  label: 'Profile',
                  isSelected: false,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
