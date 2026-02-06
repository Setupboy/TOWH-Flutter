import 'package:flutter/material.dart';

import '../../../core/theme/color.dart';
import '../../../core/theme/font.dart';

class QuickGuide extends StatelessWidget {
  const QuickGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kColorGreen50,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: kColorGreen100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.info_outline, size: 16, color: kColorBlue800),
              SizedBox(width: 8),
              Text(
                "Quick guide:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  fontFamily: kFontMPL,
                  color: kColorBlue900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text.rich(
            TextSpan(
              style: const TextStyle(
                fontSize: 14,
                fontFamily: kFontMPL,
                fontWeight: FontWeight.w400,
                color: kColorGreen200,
                height: 1.6,
              ),
              children: const [
                TextSpan(text: "Choose Player and activities, Select "),
                TextSpan(
                  text: "mystery",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: kColorGreen300,
                  ),
                ),
                TextSpan(text: "\ncolors, Decide on activity by the "),
                TextSpan(
                  text: "mystery",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: kColorGreen300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
