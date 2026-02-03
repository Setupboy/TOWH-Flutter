import 'package:flutter/material.dart';
import 'package:towh/constants/color.dart';
import 'package:towh/constants/font.dart';

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
