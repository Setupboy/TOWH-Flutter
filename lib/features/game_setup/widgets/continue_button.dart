import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';

class ContinueButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const ContinueButton({
    super.key,
    this.label = 'Continue',
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorYellow200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: kFontMPL,
            fontWeight: FontWeight.w500,
            color: kColorBlue900,
            height: 1.46,
          ),
        ),
      ),
    );
  }
}
