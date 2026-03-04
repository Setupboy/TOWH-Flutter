import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';

class ActivityInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  const ActivityInput({
    super.key,
    required this.controller,
    this.focusNode,
    this.errorText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null && errorText!.isNotEmpty;

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
          width: 348,
          height: 37,
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            onChanged: onChanged,
            enableSuggestions: false,
            keyboardType: TextInputType.text,
            cursorColor: kColorBlue800,
            textAlignVertical: TextAlignVertical.center,
            style: const TextStyle(
              fontFamily: kFontMPL,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: kColorBlue900,
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
                borderSide: BorderSide(
                  color: hasError ? kColorRed600 : kColorGray50,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: hasError ? kColorRed600 : kColorGray50,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 4),
          Text(
            errorText!,
            style: const TextStyle(
              fontFamily: kFontMPL,
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: kColorRed600,
            ),
          ),
        ],
      ],
    );
  }
}
