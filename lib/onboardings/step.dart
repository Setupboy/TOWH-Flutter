import 'package:flutter/material.dart';

class OnboardingStep {
  final String image;
  final String title;
  final String description;
  final VoidCallback? onNext;
  final VoidCallback? onSkip;

  const OnboardingStep({
    required this.image,
    required this.title,
    required this.description,
    this.onNext,
    this.onSkip,
  });
}
