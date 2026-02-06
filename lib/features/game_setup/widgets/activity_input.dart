import 'package:flutter/material.dart';

import '../../../core/theme/color.dart';
import '../../../core/theme/font.dart';

class ActivityInput extends StatelessWidget {
  const ActivityInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Activity Name',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            fontFamily: kFontMPL,
            color: kColorBlue900,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 37,
          child: TextField(
            enableSuggestions: false,
            cursorColor: kColorBlue100,
            textAlignVertical: TextAlignVertical.center,
            style: const TextStyle(
              fontFamily: kFontMPL,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: kColorBlue800,
            ),
            decoration: InputDecoration(
              hintText: 'Write an activity title',
              hintStyle: const TextStyle(
                fontFamily: kFontMPL,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: kColorBlue100,
              ),
              filled: true,
              fillColor: kColorWithe50,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: kColorGray100, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: kColorGray100, width: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
