import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:towh/core/theme/app_colors.dart';
import 'package:towh/core/theme/app_fonts.dart';
import 'package:towh/core/utils/game_session.dart';
import 'package:towh/core/utils/player_data.dart';
import 'package:towh/features/history/screens/history_view.dart';

import '../../game_setup/screens/new_game_view.dart';
import '../widgets/game_box.dart';
import '../widgets/nav_bar_item.dart';
import '../widgets/player_chip.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;
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

    return Scaffold(
      backgroundColor: kColorWhite50,

      // AppBar
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
                height: 1.0,
                color: kColorBlue900,
              ),
            ),
          ],
        ),
        foregroundColor: kColorBlue900,
        surfaceTintColor: Colors.transparent,
      ),

      // Body
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        transitionBuilder: (child, animation) =>
            FadeTransition(opacity: animation, child: child),
        child: _showPageContent
            ? SingleChildScrollView(
                key: const ValueKey<String>('home-content'),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),

                        // Welcome box
                        SizedBox(
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
                                    MaterialPageRoute(
                                      builder: (context) => const NewGameView(),
                                    ),
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
                        ),

                        const SizedBox(height: 24),

                        // In progress game
                        GameBox(
                          title: 'In progress game',
                          gameTitle:
                              GameSession.inProgressActivityName ??
                              'Restaurant Night',
                          players: inProgressPlayers
                              .map(
                                (player) => PlayerChip(
                                  name: player.name,
                                  imageUrl: player.imageUrl,
                                ),
                              )
                              .toList(),
                        ),

                        const SizedBox(height: 24),

                        // Repeat game
                        GameBox(
                          title: 'Repeat game',
                          gameTitle: 'Cafe Morning',
                          players: kDemoPlayers
                              .map(
                                (player) => PlayerChip(
                                  name: player.name,
                                  imageUrl: player.imageUrl,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox(key: ValueKey<String>('home-empty')),
      ),

      // Bottom Navigation
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
                  isSelected: selectedIndex == 0,
                  onTap: () {
                    setState(() => selectedIndex = 0);
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
                  isSelected: selectedIndex == 2,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const HistoryView()),
                    );
                  },
                ),
              ),
              Expanded(
                child: NavBarItem(
                  icon: FluentIcons.person_circle_24_regular,
                  label: 'Profile',
                  isSelected: selectedIndex == 3,
                  onTap: () => setState(() => selectedIndex = 3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
