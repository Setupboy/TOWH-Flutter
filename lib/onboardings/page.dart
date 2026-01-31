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
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: 412,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: kWitheColor50,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(400)),
          ),
          child: Center(
            child: SizedBox(
              width: step.imageWidth,
              height: step.imageHeight,
              child: Image.asset(step.image, fit: BoxFit.contain),
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Text section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                step.title,
                style: const TextStyle(
                  fontFamily: kBaloo2Font,
                  fontWeight: FontWeight.w700,
                  fontSize: 48,
                  height: 57 / 48,
                  color: kBlueColor900,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                step.description,
                style: const TextStyle(
                  fontFamily: kMPLFont,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  color: kBlueColor800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
