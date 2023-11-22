import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cache_helper/shared_preferences.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/cubits/nav_bar-cubit/nav_bar_cubit.dart';
import 'package:shop_app/cubits/nav_bar-cubit/nav_bar_cubit.dart';
import 'package:shop_app/screens/login_screen.dart';

class ShopAppScreen extends StatelessWidget {
  const ShopAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navBarCubit=NavBarCubit.get(context);
    return BlocBuilder<NavBarCubit,NavBarState>(

      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex:NavBarCubit.get(context).currentIndex,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            selectedItemColor: kPrimaryColor,
            onTap: (index) {
              navBarCubit.changeIndex(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.grid_view_rounded), label: "Categories"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "Favourite"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings"),
            ],

          ),
          body: kScreens[navBarCubit.currentIndex],
        );
      },
    );
  }

  void signOut(BuildContext context) {
    CacheHelper.remove(key: kToken).then((value) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen(),));
    });
  }
}
