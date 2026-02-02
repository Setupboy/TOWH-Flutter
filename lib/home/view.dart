import 'package:flutter/material.dart';
import 'package:towh/constants/color.dart';

class Homeview extends StatelessWidget {
  const Homeview({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWitheColor50,
      appBar: AppBar(
        backgroundColor: kWitheColor50,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/icons/icons8.png', width: 36, height: 36),
            const SizedBox(width: 8),
            const Text(
              'To W?',
              style: TextStyle(
                fontFamily: 'Baloo2',
                fontSize: 24,
                fontWeight: FontWeight.w600,
                height: 1.0,
                letterSpacing: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
