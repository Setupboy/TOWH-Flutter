import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';

class ActivityInput extends StatelessWidget {
  final TextEditingController controller;

  const ActivityInput({super.key, required this.controller});

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
            controller: controller,
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
              fillColor: kColorWhite50,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: kColorGray50, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: kColorGray50, width: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
