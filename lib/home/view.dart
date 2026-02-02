import 'package:flutter/material.dart';
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
      appBar: AppBar(
        backgroundColor: kWitheColor50,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 16,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/icons/icons8.png', width: 36, height: 36),
            const SizedBox(width: 8),
            const Text(
              'To W?',
              style: TextStyle(
                fontFamily: 'Baloo2',
                fontSize: 24,
                fontWeight: FontWeight.w600,
                height: 1.0,
                letterSpacing: 0,
                color: kBlueColor900,
              ),
            ),
          ],
        ),
        foregroundColor: kBlueColor900,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 24),
                // Box 1: Welcome + New Game
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
                          decoration: BoxDecoration(
                            color: kYellowColor200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
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
                // Box 2: In Progress Game
                SizedBox(
                  width: 380,
                  height: 232,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'In progress game',
                        style: TextStyle(
                          fontFamily: kMPLFont,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: kBlueColor800,
                          height: 1.6,
                          letterSpacing: 0,
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
                          child: InkWell(
                            borderRadius: BorderRadius.circular(24),
                            onTap: () {
                              // TODO: handle tap
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ───────────────── Row 1: title + icon ─────────────────
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'Restaurant Night',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: kBlueColor900,
                                          fontFamily: kMPLFont,
                                        ),
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        color: kBlueColor800,
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 12),

                                  // ───────────────── Row 2: players (wrap) ─────────────────
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: const [
                                      _PlayerChip(
                                        name: 'Stephen',
                                        imageUrl:
                                            'https://randomuser.me/api/portraits/men/1.jpg',
                                      ),
                                      _PlayerChip(
                                        name: 'Alice',
                                        imageUrl:
                                            'https://randomuser.me/api/portraits/women/2.jpg',
                                      ),
                                      _PlayerChip(
                                        name: 'Samuel',
                                        imageUrl:
                                            'https://randomuser.me/api/portraits/men/3.jpg',
                                      ),
                                      _PlayerChip(
                                        name: 'Tony',
                                        imageUrl:
                                            'https://randomuser.me/api/portraits/men/4.jpg',
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 12),

                                  // ───────────────── Row 3: bottom title ─────────────────
                                  Row(
                                    children: [
                                      const Text(
                                        'Stage:',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: kBlueColor800,
                                          fontFamily: kMPLFont,
                                          height: 1.0,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      const Text(
                                        'Voting',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: kBlueColor900,
                                          fontFamily: kMPLFont,
                                          height: 1.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Box 3: Repeat game
                SizedBox(
                  width: 380,
                  height: 232,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Repeat game',
                        style: TextStyle(
                          fontFamily: kMPLFont,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: kBlueColor800,
                          height: 1.6,
                          letterSpacing: 0,
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
                          child: InkWell(
                            borderRadius: BorderRadius.circular(24),
                            onTap: () {
                              // TODO: handle tap
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ───────────────── Row 1: title + icon ─────────────────
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'Cafe Morning',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: kBlueColor900,
                                          fontFamily: kMPLFont,
                                        ),
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        color: kBlueColor800,
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 12),

                                  // ───────────────── Row 2: players (wrap) ─────────────────
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: const [
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

                                  const SizedBox(height: 12),

                                  // ───────────────── Row 3: bottom title ─────────────────
                                  Row(
                                    children: [
                                      const Text(
                                        'Stage:',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: kBlueColor800,
                                          fontFamily: kMPLFont,
                                          height: 1.0,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      const Text(
                                        'Voting',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: kBlueColor900,
                                          fontFamily: kMPLFont,
                                          height: 1.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kYellowColor200,
        unselectedItemColor: kBlueColor800,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: 'Play',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: 'Templates',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
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
