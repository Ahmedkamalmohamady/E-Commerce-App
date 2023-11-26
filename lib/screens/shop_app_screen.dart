import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cache_helper/shared_preferences.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/cubits/home_cubit/home_cubit.dart';
import 'package:shop_app/cubits/home_cubit/home_cubit.dart';
import 'package:shop_app/cubits/nav_bar-cubit/nav_bar_cubit.dart';
import 'package:shop_app/cubits/nav_bar-cubit/nav_bar_cubit.dart';
import 'package:shop_app/screens/login_screen.dart';

import '../widgets/custom_widgets.dart';

class ShopAppScreen extends StatelessWidget {
  const ShopAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navBarCubit = NavBarCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if(state is ChangeFavouriteItemSuccess)
        {
          ShowToastMessage(msg: state.msg,color: Colors.green);
        }
        if(state is ChangeFavouriteItemFailed)
        {
          ShowToastMessage(msg: state.msg,color: Colors.red);
        }
      },
      builder: (context, state) {
        return BlocBuilder<NavBarCubit, NavBarState>(

          builder: (context, state) {
            return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: NavBarCubit
                    .get(context)
                    .currentIndex,
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: true,
                selectedItemColor: kPrimaryColor,
                onTap: (index) {
                  navBarCubit.changeIndex(index);
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  // BottomNavigationBarItem(
                  //     icon: Icon(Icons.grid_view_rounded), label: "Categories"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: "Favourite"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "Profile"),
                ],

              ),
              body: kScreens[navBarCubit.currentIndex],
            );
          },
        );
      },
    );
}


}
void signOut(BuildContext context) {

  CacheHelper.remove(key: kToken).then((value) {
    NavBarCubit.get(context).currentIndex=0;
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const LoginScreen(),));
  });
}