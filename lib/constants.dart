import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/screens/categories_screen.dart';
import 'package:shop_app/screens/favourite_screen.dart';
import 'package:shop_app/screens/home_screen.dart';
import 'package:shop_app/screens/shop_app_screen.dart';
import 'package:shop_app/screens/settings_screen.dart';

import 'models/onboarding_model.dart';

const  kPrimaryColor=Color(0xff6C63FD);
List<PageModel> onBoardingPages=[
  PageModel(title: 'Prepare Your shopping cart', subTitle: 'Be ready and prepare your shopping cart and enjoy with shopping ', image: 'assets/images/onboarding_1.svg'),
  PageModel(title: 'Choose your needs ', subTitle: 'choose your needs and don\'t miss the new collection', image: 'assets/images/onboarding_3.svg'),
  PageModel(title: 'Enjoy with your purchases', subTitle: 'Congratulations on your purchases and happy shopping', image: 'assets/images/onboarding_2.svg')
];
var customTextStyle=GoogleFonts.openSans;
const String kOnBoarding='onBoarding';
const String kDarkMode='darkMode';
const String kToken='token';
List<Widget>kScreens=[const HomeScreen(),const FavouriteScreen(),const SettingScreen()];
const String homeEndPoint='home';
const String categoryEndPoint='categories';
dynamic token='';