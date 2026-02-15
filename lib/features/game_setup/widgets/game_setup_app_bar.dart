import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';

PreferredSizeWidget gameSetupAppBar(
  BuildContext context, {
  required VoidCallback onBack,
  String title = 'Game Set Up',
}) {
  return AppBar(
    foregroundColor: kColorBlue900,
    surfaceTintColor: Colors.transparent,
    backgroundColor: kColorWhite50,
    elevation: 0,
    automaticallyImplyLeading: false,
    titleSpacing: 16,
    title: Row(
      children: [
        GestureDetector(
          onTap: onBack,
          child: Icon(Icons.arrow_back_ios_new, size: 20, color: kColorBlue800),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontFamily: kFontBaloo2,
            fontWeight: FontWeight.w600,
            color: kColorBlue900,
            height: 1.0,
          ),
        ),
      ],
    ),
  );
}
