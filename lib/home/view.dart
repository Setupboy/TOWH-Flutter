import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:towh/constants/color.dart';
import 'package:towh/constants/font.dart';

import 'widgets/game_box.dart';
import 'widgets/nav_bar_item.dart';
import 'widgets/player_chip.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWithe50,

      // AppBar
      appBar: AppBar(
        backgroundColor: kColorWithe50,
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
      body: SingleChildScrollView(
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
                            MaterialPageRoute(builder: (context) => NewGame()),
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
                  gameTitle: 'Restaurant Night',
                  players: [
                    PlayerChip(
                      name: 'Stephen',
                      imageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
                    ),
                    PlayerChip(
                      name: 'Alice',
                      imageUrl:
                          'https://randomuser.me/api/portraits/women/2.jpg',
                    ),
                    PlayerChip(
                      name: 'Samuel',
                      imageUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
                    ),
                    PlayerChip(
                      name: 'Tony',
                      imageUrl: 'https://randomuser.me/api/portraits/men/4.jpg',
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Repeat game
                GameBox(
                  title: 'Repeat game',
                  gameTitle: 'Cafe Morning',
                  players: [
                    PlayerChip(
                      name: 'Stephen',
                      imageUrl:
                          'https://randomuser.me/api/portraits/men/12.jpg',
                    ),
                    PlayerChip(
                      name: 'Alice',
                      imageUrl:
                          'https://randomuser.me/api/portraits/women/20.jpg',
                    ),
                    PlayerChip(
                      name: 'Samuel',
                      imageUrl:
                          'https://randomuser.me/api/portraits/men/22.jpg',
                    ),
                    PlayerChip(
                      name: 'Tony',
                      imageUrl:
                          'https://randomuser.me/api/portraits/men/40.jpg',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        height: 64,
        decoration: BoxDecoration(
          color: kColorWithe100,
          borderRadius: BorderRadius.circular(24),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Row(
            children: [
              Expanded(
                child: NavBarItem(
                  iconPath: 'assets/icons/play.svg',
                  label: 'Play',
                  isSelected: selectedIndex == 0,
                  onTap: () => setState(() => selectedIndex = 0),
                ),
              ),
              Expanded(
                child: NavBarItem(
                  iconPath: 'assets/icons/templates.svg',
                  label: 'Templates',
                  isSelected: selectedIndex == 1,
                  onTap: () => setState(() => selectedIndex = 1),
                ),
              ),
              Expanded(
                child: NavBarItem(
                  iconPath: 'assets/icons/game_history.svg',
                  label: 'History',
                  isSelected: selectedIndex == 2,
                  onTap: () => setState(() => selectedIndex = 2),
                ),
              ),
              Expanded(
                child: NavBarItem(
                  iconPath: 'assets/icons/profile.svg',
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

class NewGame extends StatefulWidget {
  const NewGame({super.key});

  @override
  State<NewGame> createState() => _NewGameState();
}

class _NewGameState extends State<NewGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWithe50,
      appBar: AppBar(
        backgroundColor: kColorWithe50,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        title: Row(
          children: [
            Icon(Icons.arrow_back_ios_new, size: 20, color: kColorBlue800),
            const SizedBox(width: 12),
            Text(
              'Game Set Up',
              style: TextStyle(
                fontSize: 24,
                fontFamily: kFontBaloo2,
                fontWeight: FontWeight.w600,
                color: kColorBlue900,
                letterSpacing: 0,
                height: 1.0,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Center(
              child: Text(
                "Let’s get the polling hit Up and running",
                style: TextStyle(
                  color: kColorBlue800,
                  fontFamily: kFontMPL,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.6,
                  letterSpacing: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
