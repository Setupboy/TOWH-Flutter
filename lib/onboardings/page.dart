import 'package:flutter/material.dart';

import '../constants/color.dart';
import '../constants/font.dart';
import 'step.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingStep step;

  const OnboardingPage({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image section
        Container(
          height: 412,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: kWitheColor50,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(400)),
          ),
          child: Image.asset(step.image, fit: BoxFit.contain),
        ),

        const SizedBox(height: 24),

        // Text section
        SizedBox(
          width: 364,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                step.title,
                style: const TextStyle(
                  fontFamily: kBaloo2Font,
                  fontWeight: FontWeight.w700,
                  fontSize: 48,
                  color: kBlueColor900,
                  height: 57 / 48,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                step.description,
                style: const TextStyle(
                  fontFamily: kMPLFont,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: kBlueColor800,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
