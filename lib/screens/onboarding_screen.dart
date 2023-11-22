import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/cache_helper/shared_preferences.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/onboarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/custom_onboarding_screen.dart';
import 'login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;
  void removeOnBoardingScreen()
  async{
    await CacheHelper.saveData(key: kOnBoarding,value: false).
    then(
            (value)
        {
          print('success');
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    var pageController = PageController();
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            actions: [
              TextButton(
                  onPressed: () {
                  removeOnBoardingScreen();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  },
                  child: Text(
                    'Skip',
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                  ))
            ],
            elevation: 0),
        body: PageView.builder(
          onPageChanged: (index) {
            if (index == onBoardingPages.length - 1) {
              setState(() {
                isLast = true;
              });
            } else {
              setState(() {
                isLast = false;
              });
            }
          },
          physics: BouncingScrollPhysics(),
          itemCount: onBoardingPages.length,
          controller: pageController,
          itemBuilder: (context, index) => CustomOnboardingScreen(pageController: pageController, isLast: isLast,pageModel: onBoardingPages[index]),
        ));
  }
}


