import 'package:flutter/material.dart';

class OnboardingStep {
  final String image;
  final String title;
  final String description;
  final double imageWidth;
  final double imageHeight;
  final VoidCallback onNext;

  const OnboardingStep({
    required this.image,
    required this.title,
    required this.description,
    required this.imageWidth,
    required this.imageHeight,
    required this.onNext,
  });
}
