import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shop_app/cache_helper/shared_preferences.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/cubits/cart_cubit/cart_cubit.dart';
import 'package:shop_app/cubits/home_cubit/home_cubit.dart';
import 'package:shop_app/cubits/nav_bar-cubit/nav_bar_cubit.dart';
import 'package:shop_app/screens/login_screen.dart';
import '../widgets/custom_widgets.dart';
import 'cart_screen.dart';

class ShopAppScreen extends StatelessWidget {
  const ShopAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int itemsNumber=0;
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
              floatingActionButton: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen(),));
                },
                child: BlocConsumer<CartCubit,CartState>(
                  listener: (context, state) {
                    if(state is AddingToCartSuccess)
                    {
                    itemsNumber=CartCubit.get(context).myCart!.data.cartItems.length;
                    print( itemsNumber);

                    }
                  },
                builder: (context, state) {
                  return Stack(
                  alignment: Alignment.center,
                  children: [
                     CircleAvatar(radius: 32.r,backgroundColor: kPrimaryColor),
                     CircleAvatar(backgroundColor: kPrimaryColor,radius: 32.r,child:(state is GetCartLoading ||state is AddingToCartLoading)?const CircularProgressIndicator(color: Colors.white,): Icon(LineAwesomeIcons.shopping_cart,size: 30.spMax,)),
                    if(CartCubit.get(context).cartItems!=null&&CartCubit.get(context).myCart!.data.cartItems.isNotEmpty)Positioned(top: -1.h,right: 6.w,child: CircleAvatar(backgroundColor: Colors.white,radius: 12.r,child: Text(CartCubit.get(context).myCart!.data.cartItems.length.toString(),style: TextStyle(color: Colors.red,fontSize: 16.sp,fontWeight: FontWeight.bold)),))

                  ],
                );
             },
           ),
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