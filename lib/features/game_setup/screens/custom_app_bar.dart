import 'package:flutter/material.dart';

import '../../../core/theme/color.dart';
import '../../../core/theme/font.dart';
import '../../home/screens/home_view.dart';

PreferredSizeWidget customAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: kColorWithe50,
    elevation: 0,
    automaticallyImplyLeading: false,
    titleSpacing: 16,
    title: Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const Homeview()),
            );
          },
          child: Icon(Icons.arrow_back_ios_new, size: 20, color: kColorBlue800),
        ),
        const SizedBox(width: 12),
        const Text(
          'Game Set Up',
          style: TextStyle(
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
