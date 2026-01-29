// Onboarding Screen
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2C230),
      appBar: AppBar(
        backgroundColor: Color(0xFFF9F6ED),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Skip action
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Skip',
                  style: TextStyle(
                    color: Color(0xA80E251F),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'MPLUSR1',
                  ),
                ),
                SizedBox(width: 6),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Color(0xA80E251F),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top image with curved corner
            Container(
              height: 412,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFF9F6ED),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(400),
                ),
              ),
              child: Image.asset(
                'assets/images/onboardings/first.png',
                fit: BoxFit.contain,
              ),
            ),

            SizedBox(height: 24),

            // Text content
            SizedBox(
              width: 364,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'Never Argue Where To Go',
                    style: TextStyle(
                      fontFamily: 'Baloo2',
                      fontWeight: FontWeight.w700,
                      fontSize: 48,
                      color: Color(0xFF0E251F),
                      height: 57 / 48,
                      letterSpacing: 0,
                    ),
                  ),

                  SizedBox(height: 16),

                  Text(
                    'Make group decisions with your friends\nusing a creative poll system.',
                    style: TextStyle(
                      fontFamily: 'MPLUSR1',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xA80E251F),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            Spacer(),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 96,
                    height: 45,
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: 3,
                      effect: ExpandingDotsEffect(
                        dotWidth: 10,
                        dotHeight: 10,
                        spacing: 4,
                        activeDotColor: Color(0xFFF9F6ED),
                        dotColor: Color(0xFFFFE081),
                        expansionFactor: 2,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 96,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Navigate to next page
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF9F6ED),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Next',
                            style: TextStyle(
                              fontFamily: 'MPLUSR1',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0E251F),
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Color(0xFF0E251F),
                          ),
                        ],
                      ),
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
