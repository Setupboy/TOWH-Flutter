import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';

class QuickGuide extends StatelessWidget {
  const QuickGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 162,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kColorGreen50,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: kColorGreen100, width: 1),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
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
            SizedBox(height: 7),
            _GuideItem(
              number: '1.',
              text: 'Choose an activity you want to do with your friends,',
            ),
            SizedBox(height: 0),
            _GuideItem(number: '2.', text: 'Each choose their likings'),
            SizedBox(height: 0),
            _GuideItem(
              number: '3.',
              text: 'Vote to a caller and name the winner',
            ),
          ],
        ),
      ),
    );
  }
}

class _GuideItem extends StatelessWidget {
  const _GuideItem({required this.number, required this.text});

  final String number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 18,
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: kFontMPL,
              fontWeight: FontWeight.w400,
              color: kColorBlue800,
              height: 1.625,
            ),
          ),
        ),
        const SizedBox(width: 2),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: kFontMPL,
              fontWeight: FontWeight.w400,
              color: kColorBlue800,
              height: 1.625,
            ),
          ),
        ),
      ],
    );
  }
}
