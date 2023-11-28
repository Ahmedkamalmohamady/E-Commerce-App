import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shop_app/cache_helper/shared_preferences.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/cubits/cart_cubit/cart_cubit.dart';
import 'package:shop_app/cubits/home_cubit/home_cubit.dart';
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
              floatingActionButton: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(radius: 35,backgroundColor: Colors.transparent),
                  CircleAvatar(radius: 30,child: Icon(LineAwesomeIcons.shopping_cart)),
                  Positioned(top: 0,right: 8,child: CircleAvatar(backgroundColor: Colors.white,radius: 12,child: Text('13',style: TextStyle(color: kPrimaryColor,fontSize: 12,fontWeight: FontWeight.bold)),))

                ],
              ),
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