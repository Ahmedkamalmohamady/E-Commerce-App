import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/bloc_observer/Bloc_observer.dart';
import 'package:shop_app/cache_helper/shared_preferences.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/cubits/home_cubit/home_cubit.dart';
import 'package:shop_app/cubits/login_cubit/login_cubit.dart';
import 'package:shop_app/cubits/nav_bar-cubit/nav_bar_cubit.dart';
import 'package:shop_app/cubits/user_cubit/user_cubit.dart';
import 'package:shop_app/screens/shop_app_screen.dart';
import 'package:shop_app/screens/login_screen.dart';
import 'package:shop_app/screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  Bloc.observer = MyBlocObserver();
  dynamic onBoarding = await CacheHelper.getData(key: kOnBoarding);
  token =await CacheHelper.getData(key: kToken);
  Widget widget;
  if (onBoarding == false) {
    if (token != null) {
      widget = const ShopAppScreen();
    }
    else {
      widget = const LoginScreen();
    }
  }
  else {
    widget = const OnBoardingScreen();
  }
  print(token);
  runApp(ShopApp(home: widget));
}

class ShopApp extends StatelessWidget {
  const ShopApp({super.key, required this.home});

  final Widget home;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit(),),
        BlocProvider(create: (context) => NavBarCubit(),),
        BlocProvider(create: (context) => HomeCubit()..getData()..getFavouritesProducts(),),
        BlocProvider(create: (context) => UserCubit()..getUserProfile(),),
      ],
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.indigo,
            fontFamily: GoogleFonts
                .openSans()
                .fontFamily,
            navigationBarTheme: const NavigationBarThemeData(
              labelTextStyle: MaterialStatePropertyAll(
                TextStyle(color: kPrimaryColor),),
              indicatorColor: kPrimaryColor,

            )
        ),

        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: home,
      ),
    );
  }
}


