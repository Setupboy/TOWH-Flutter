import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:towh/core/theme/color.dart';
import 'package:towh/core/theme/font.dart';
import 'package:towh/core/utils/image.dart';
import 'package:towh/features/home/screens/home_view.dart';

import '../models/onboarding_step.dart';
import '../widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
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
      ),
      OnboardingStep(
        image: kOnboardingStep2Img,
        title: 'Vote Without Pressure',
        description: 'Everyone picks secretly — no names,\njust fun choices.',
        imageWidth: 351,
        imageHeight: 336,
      ),
      OnboardingStep(
        image: kOnboardingStep3Img,
        title: 'Vote With Mystery',
        description: 'Everyone picks secretly — no names,\njust fun choices.',
        imageWidth: 369,
        imageHeight: 330,
      ),
    ];
  }

  void _nextPage() {
    if (_currentIndex < _steps.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      _finishOnboarding();
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  void _finishOnboarding() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Homeview()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorYellow200,
      appBar: AppBar(
        backgroundColor: kColorWithe50,
        elevation: 0,
        leading: _currentIndex > 0
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: kColorBlue900,
                ),
                onPressed: _previousPage,
              )
            : null,
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
                      fontFamily: kFontMPL,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: kColorBlue800,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward_ios, size: 14, color: kColorBlue800),
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
              child: Stack(
                children: [
                  Container(
                    height: 412,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: kColorWithe50,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(400),
                      ),
                    ),
                  ),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    switchInCurve: Curves.easeIn,
                    switchOutCurve: Curves.easeOut,
                    transitionBuilder: (child, animation) =>
                        FadeTransition(opacity: animation, child: child),
                    child: OnboardingPage(
                      key: ValueKey<int>(_currentIndex),
                      step: _steps[_currentIndex],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: PageController(initialPage: _currentIndex),
                    count: _steps.length,
                    effect: ExpandingDotsEffect(
                      dotWidth: 10,
                      dotHeight: 10,
                      spacing: 4,
                      activeDotColor: kColorWithe50,
                      dotColor: kColorYellow100,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kColorWithe50,
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
                            fontFamily: kFontMPL,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: kColorBlue900,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: kColorBlue900,
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
