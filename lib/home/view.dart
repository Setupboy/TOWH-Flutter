import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:towh/constants/color.dart';
import 'package:towh/constants/font.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWitheColor50,

      // ───────────────── AppBar ─────────────────
      appBar: AppBar(
        backgroundColor: kWitheColor50,
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
                kYellowColor200, // apply the color you want
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
                color: kBlueColor900,
              ),
            ),
          ],
        ),
        foregroundColor: kBlueColor900,
        surfaceTintColor: Colors.transparent,
      ),

      // ───────────────── Body ─────────────────
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
                          color: kBlueColor900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Create a new game with friends present',
                        style: TextStyle(
                          fontFamily: kMPLFont,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.625,
                          color: kBlueColor800,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 380,
                          height: 124,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: kYellowColor200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            '+ New Game',
                            style: TextStyle(
                              fontFamily: kMPLFont,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: kBlueColor900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // In progress game
                _GameBox(
                  title: 'In progress game',
                  gameTitle: 'Restaurant Night',
                  players: [
                    _PlayerChip(
                      name: 'Stephen',
                      imageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
                    ),
                    _PlayerChip(
                      name: 'Alice',
                      imageUrl:
                          'https://randomuser.me/api/portraits/women/2.jpg',
                    ),
                    _PlayerChip(
                      name: 'Samuel',
                      imageUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
                    ),
                    _PlayerChip(
                      name: 'Tony',
                      imageUrl: 'https://randomuser.me/api/portraits/men/4.jpg',
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Repeat game
                _GameBox(
                  title: 'Repeat game',
                  gameTitle: 'Cafe Morning',
                  players: [
                    _PlayerChip(
                      name: 'Stephen',
                      imageUrl:
                          'https://randomuser.me/api/portraits/men/12.jpg',
                    ),
                    _PlayerChip(
                      name: 'Alice',
                      imageUrl:
                          'https://randomuser.me/api/portraits/women/20.jpg',
                    ),
                    _PlayerChip(
                      name: 'Samuel',
                      imageUrl:
                          'https://randomuser.me/api/portraits/men/22.jpg',
                    ),
                    _PlayerChip(
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

      // ───────────────── Bottom Navigation ─────────────────
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        height: 80,
        decoration: BoxDecoration(
          color: kWitheColor100,
          borderRadius: BorderRadius.circular(24),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Row(
            children: [
              Expanded(
                child: _NavBarItem(
                  iconPath: 'assets/icons/play.svg',
                  label: 'Play',
                  isSelected: true,
                  onTap: () {},
                ),
              ),
              Expanded(
                child: _NavBarItem(
                  iconPath: 'assets/icons/templates.svg',
                  label: 'Templates',
                  isSelected: false,
                  onTap: () {},
                ),
              ),
              Expanded(
                child: _NavBarItem(
                  iconPath: 'assets/icons/game_history.svg',
                  label: 'History',
                  isSelected: false,
                  onTap: () {},
                ),
              ),
              Expanded(
                child: _NavBarItem(
                  iconPath: 'assets/icons/profile.svg',
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

class _NavBarItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.iconPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? kYellowColor200 : Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                isSelected ? kBlueColor900 : kBlueColor800,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? kBlueColor900 : kBlueColor800,
                fontWeight: FontWeight.w400,
                fontFamily: kMPLFont,
                height: 1.0,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GameBox extends StatelessWidget {
  final String title;
  final String gameTitle;
  final List<Widget> players;

  const _GameBox({
    required this.title,
    required this.gameTitle,
    required this.players,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      height: 232,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: kMPLFont,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: kBlueColor800,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 380,
            height: 194,
            child: Card(
              color: kWitheColor100,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          gameTitle,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: kBlueColor900,
                            fontFamily: kMPLFont,
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: kBlueColor800),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(spacing: 8, runSpacing: 8, children: players),
                    const SizedBox(height: 12),
                    Row(
                      children: const [
                        Text(
                          'Stage:',
                          style: TextStyle(
                            fontSize: 12,
                            color: kBlueColor800,
                            fontFamily: kMPLFont,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Voting',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: kBlueColor900,
                            fontFamily: kMPLFont,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayerChip extends StatelessWidget {
  final String name;
  final String imageUrl;

  const _PlayerChip({required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        border: Border.all(color: kYellowColor200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(radius: 13, backgroundImage: NetworkImage(imageUrl)),
          const SizedBox(width: 6),
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: kBlueColor900,
              fontFamily: kMPLFont,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
