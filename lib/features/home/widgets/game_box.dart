import 'package:flutter/material.dart';
import 'package:towh/core/theme/app_colors.dart';
import 'package:towh/core/theme/app_fonts.dart';

class GameBox extends StatelessWidget {
  final String title;
  final String gameTitle;
  final List<Widget> players;

  const GameBox({
    required this.title,
    required this.gameTitle,
    required this.players,
    super.key,
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
              fontFamily: kFontMPL,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: kColorBlue800,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 380,
            height: 194,
            child: Card(
              color: kColorWhite100,
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
                            color: kColorBlue900,
                            fontFamily: kFontMPL,
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: kColorBlue800),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(spacing: 8, runSpacing: 8, children: players),
                    const Spacer(),
                    Row(
                      children: const [
                        Text(
                          'Stage:',
                          style: TextStyle(
                            fontSize: 12,
                            color: kColorBlue800,
                            fontFamily: kFontMPL,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Voting',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: kColorBlue900,
                            fontFamily: kFontMPL,
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
