// Onboarding Screen
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:towh/utilities/font_constants.dart';
import 'package:towh/utilities/image_constants.dart';

import '../utilities/color_constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

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
      backgroundColor: kYellowColor200,
      appBar: AppBar(
        backgroundColor: kWitheColor50,
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
            // Top image with curved corner
            Container(
              height: 412,
              width: double.infinity,
              decoration: BoxDecoration(
                color: kWitheColor50,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(400),
                ),
              ),
              child: Image.asset(kOnboardingStep1Img, fit: BoxFit.contain),
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
                      fontFamily: kBaloo2Font,
                      fontWeight: FontWeight.w700,
                      fontSize: 48,
                      color: kBlueColor900,
                      height: 57 / 48,
                      letterSpacing: 0,
                    ),
                  ),

                  SizedBox(height: 16),

                  Text(
                    'Make group decisions with your friends\nusing a creative poll system.',
                    style: TextStyle(
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
                        activeDotColor: kWitheColor50,
                        dotColor: kYellowColor100,
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
                        backgroundColor: kWitheColor50,
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
