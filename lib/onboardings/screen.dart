import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constants/color.dart';
import '../constants/font.dart';
import '../constants/image.dart';
import 'page.dart';
import 'step.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int _currentIndex = 0;

  late final List<OnboardingStep> _steps;

  @override
  void initState() {
    super.initState();

    _steps = [
      OnboardingStep(
        image: kOnboardingStep1Img,
        title: 'Never Argue Where To Go',
        description:
            'Make group decisions with your friends\nusing a creative poll system.',
        imageWidth: 300,
        imageHeight: 418,
        onNext: _nextPage,
      ),
      OnboardingStep(
        image: kOnboardingStep2Img,
        title: 'Vote Without Pressure',
        description: 'Everyone picks secretly — no names,\njust fun choices.',
        imageWidth: 351,
        imageHeight: 336,
        onNext: _nextPage,
      ),
      OnboardingStep(
        image: kOnboardingStep3Img,
        title: 'Vote with Mystery',
        description: 'Everyone picks secretly — no names,\njust fun choices.',
        imageWidth: 369,
        imageHeight: 330,
        onNext: _finishOnboarding,
      ),
    ];
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void _finishOnboarding() {
    // TODO: Navigate to home screen
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kYellowColor200,
      appBar: AppBar(
        backgroundColor: kWitheColor50,
        elevation: 0,

        // ✅ BACK BUTTON — APPEARS IMMEDIATELY
        leading: _currentIndex > 0
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: kBlueColor900,
                ),
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
              )
            : const SizedBox.shrink(),

        // ✅ SKIP BUTTON WITH PROPER SPACING
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton(
              onPressed: _finishOnboarding,
              child: const Row(
                children: [
                  Text(
                    'Skip',
                    style: TextStyle(
                      fontFamily: kMPLFont,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: kBlueColor800,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward_ios, size: 14, color: kBlueColor800),
                ],
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _steps.length,

                // ✅ THIS MAKES BACK BUTTON INSTANT
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },

                itemBuilder: (_, index) {
                  return OnboardingPage(step: _steps[index]);
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _steps.length,
                    effect: ExpandingDotsEffect(
                      dotWidth: 10,
                      dotHeight: 10,
                      spacing: 4,
                      activeDotColor: kWitheColor50,
                      dotColor: kYellowColor100,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _steps[_currentIndex].onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kWitheColor50,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(
                            fontFamily: kMPLFont,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: kBlueColor900,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: kBlueColor900,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
