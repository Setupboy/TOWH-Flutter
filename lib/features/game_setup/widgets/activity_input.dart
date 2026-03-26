import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';

class ActivityInput extends StatelessWidget {
  static const List<String> _activitySuggestions = <String>[
    'Dinner',
    'Outgoing',
    'Nature',
    'Lunch',
    'Party',
    'Gathering',
    'gaming',
  ];

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
        const SizedBox(height: 16),
        SizedBox(
          height: 34,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemCount: _activitySuggestions.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final suggestion = _activitySuggestions[index];
              return _ActivitySuggestionChip(
                label: suggestion,
                isSelected:
                    controller.text.trim().toLowerCase() ==
                    suggestion.toLowerCase(),
                onTap: () {
                  controller.value = TextEditingValue(
                    text: suggestion,
                    selection: TextSelection.collapsed(
                      offset: suggestion.length,
                    ),
                  );
                  onChanged?.call(suggestion);
                  focusNode?.unfocus();
                },
              );
            },
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

class _ActivitySuggestionChip extends StatelessWidget {
  const _ActivitySuggestionChip({
    required this.label,
    required this.onTap,
    required this.isSelected,
  });

  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 60, minHeight: 34),
          child: Ink(
            height: 34,
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
            decoration: BoxDecoration(
              color: isSelected ? kColorYellow100 : kColorWhite100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kColorYellow200, width: 1),
            ),
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  fontFamily: kFontMPL,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: kColorBlue900,
                  height: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
