import 'package:flutter/material.dart';

import '../../../core/theme/color.dart';
import '../../../core/theme/font.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      height: 48,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorYellow200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Continue',
          style: TextStyle(
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
