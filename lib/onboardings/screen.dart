import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constants//color.dart';
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
  late final PageController _pageController;
  late final List<OnboardingStep> _steps;

  @override
  void initState() {
    _pageController = PageController();

    _steps = [
      OnboardingStep(
        image: kOnboardingStep1Img,
        title: 'Never Argue Where To Go',
        description:
            'Make group decisions with your friends\nusing a creative poll system.',
        onNext: _nextPage,
      ),
      OnboardingStep(
        image: kOnboardingStep1Img,
        title: 'Vote Without Pressure',
        description: 'Everyone picks secretly — no names, just\nfun choices.',
        onNext: _nextPage,
      ),
      OnboardingStep(
        image: kOnboardingStep1Img,
        title: 'Vote with Mystery',
        description: 'Everyone picks secretly — no names, just\nfun choices.',
        onNext: _finishOnboarding,
      ),
    ];

    super.initState();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
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
        actions: [
          TextButton(
            onPressed: _finishOnboarding,
            child: Row(
              children: const [
                Text(
                  'Skip',
                  style: TextStyle(
                    color: kBlueColor800,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: kMPLFont,
                  ),
                ),
                SizedBox(width: 6),
                Icon(Icons.arrow_forward_ios, size: 14, color: kBlueColor800),
              ],
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
                itemBuilder: (context, index) {
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
                    onPressed: () {
                      final index = _pageController.page?.round() ?? 0;
                      _steps[index].onNext?.call();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kWitheColor50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Row(
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(
                            fontFamily: kMPLFont,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: kBlueColor800,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: kBlueColor800,
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
