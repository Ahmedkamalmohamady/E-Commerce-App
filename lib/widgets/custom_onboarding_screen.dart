import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../cache_helper/shared_preferences.dart';
import '../constants.dart';
import '../models/onboarding_model.dart';
import '../screens/login_screen.dart';

class CustomOnboardingScreen extends StatelessWidget {


  const CustomOnboardingScreen({
    super.key,
    required this.pageController,
    required this.isLast,
    required this.pageModel,
  });

  final PageController pageController;
  final bool isLast;
  final PageModel pageModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(
                  pageModel.image,
                  clipBehavior: Clip.none,
                ),
              )),
          Text(pageModel.title,
              style:
              const TextStyle(fontSize: 26,color: kPrimaryColor)),
          Text(
              pageModel.subTitle,
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
          const SizedBox(
            height: 100,
          ),
          Row(
            children: [
              SmoothPageIndicator(
                count: onBoardingPages.length,
                controller: pageController,
                effect: const SlideEffect(
                  radius: 25,
                  dotHeight: 12,
                  dotWidth: 12,
                ),
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    if (isLast) {
                      removeOnBoardingScreen();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ));
                    } else {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut);
                    }
                  },
                  child: Text(
                    isLast ? 'Login' : 'Next',
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}