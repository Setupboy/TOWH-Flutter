import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:towh/core/theme/color.dart';
import 'package:towh/core/theme/font.dart';
import 'package:towh/core/utils/player_data.dart';
import 'package:towh/features/home/screens/home_view.dart';
import 'package:towh/features/home/widgets/nav_bar_item.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    final inProgressGame = _HistoryGame(
      title: 'Restaurant Night',
      players: kDemoPlayers,
      footerLeftLabel: 'Stage:',
      footerLeftValue: 'Voting',
    );

    final repeatCafeGame = _HistoryGame(
      title: 'Cafe Morning',
      players: kDemoPlayers,
      footerLeftLabel: 'Winner:',
      footerLeftValue: 'Steak',
      footerRightLabel: 'By:',
      footerRightValue: 'Alice',
    );

    final repeatCampingGame = _HistoryGame(
      title: 'Camping',
      players: const [
        PlayerData(
          name: 'Alice',
          imageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
        ),
        PlayerData(
          name: 'Stephen',
          imageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
        ),
        PlayerData(
          name: 'Samuel',
          imageUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
        ),
        PlayerData(
          name: 'Tony',
          imageUrl: 'https://randomuser.me/api/portraits/men/4.jpg',
        ),
        PlayerData(
          name: 'Mendy',
          imageUrl: 'https://randomuser.me/api/portraits/women/5.jpg',
        ),
      ],
    );

    return Scaffold(
      backgroundColor: kColorWithe50,
      appBar: AppBar(
        backgroundColor: kColorWithe50,
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                const _SectionTitle('In progress game'),
                const SizedBox(height: 8),
                _HistoryGameCard(game: inProgressGame),
                const SizedBox(height: 24),
                const _SectionTitle('Repeat game'),
                const SizedBox(height: 8),
                _HistoryGameCard(game: repeatCafeGame),
                const SizedBox(height: 4),
                _HistoryGameCard(game: repeatCampingGame),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        height: 64,
        width: 380,
        decoration: BoxDecoration(
          color: kColorWithe100,
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
                      MaterialPageRoute(builder: (_) => const Homeview()),
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

class _SectionTitle extends StatelessWidget {
  final String value;

  const _SectionTitle(this.value);

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: const TextStyle(
        fontFamily: kFontMPL,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: kColorBlue800,
        height: 1.86,
      ),
    );
  }
}

class _HistoryGame {
  final String title;
  final List<PlayerData> players;
  final String? footerLeftLabel;
  final String? footerLeftValue;
  final String? footerRightLabel;
  final String? footerRightValue;

  const _HistoryGame({
    required this.title,
    required this.players,
    this.footerLeftLabel,
    this.footerLeftValue,
    this.footerRightLabel,
    this.footerRightValue,
  });

  bool get hasFooterLeft =>
      (footerLeftLabel?.isNotEmpty ?? false) &&
      (footerLeftValue?.isNotEmpty ?? false);

  bool get hasFooterRight =>
      (footerRightLabel?.isNotEmpty ?? false) &&
      (footerRightValue?.isNotEmpty ?? false);
}

class _HistoryGameCard extends StatelessWidget {
  final _HistoryGame game;

  const _HistoryGameCard({required this.game});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kColorWithe100,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  game.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: kColorBlue900,
                    fontFamily: kFontMPL,
                    height: 1.0,
                  ),
                ),
                const Icon(Icons.chevron_right, color: kColorBlue800, size: 24),
              ],
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: game.players.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 46,
              ),
              itemBuilder: (context, index) {
                final player = game.players[index];
                return _HistoryPlayerChip(
                  name: player.name,
                  imageUrl: player.imageUrl,
                );
              },
            ),
            if (game.hasFooterLeft) const SizedBox(height: 12),
            if (game.hasFooterLeft)
              Row(
                children: [
                  Text(
                    game.footerLeftLabel!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: kColorBlue800,
                      fontFamily: kFontMPL,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    game.footerLeftValue!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: kColorBlue900,
                      fontFamily: kFontMPL,
                      height: 1.0,
                    ),
                  ),
                  const Spacer(),
                  if (game.hasFooterRight) ...[
                    Text(
                      game.footerRightLabel!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: kColorBlue800,
                        fontFamily: kFontMPL,
                        fontWeight: FontWeight.w400,
                        height: 1.0,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      game.footerRightValue!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: kColorBlue900,
                        fontFamily: kFontMPL,
                        height: 1.0,
                      ),
                    ),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _HistoryPlayerChip extends StatelessWidget {
  final String name;
  final String imageUrl;

  const _HistoryPlayerChip({required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        border: Border.all(color: kColorYellow200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 12, backgroundImage: NetworkImage(imageUrl)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: kColorBlue900,
                fontFamily: kFontMPL,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
