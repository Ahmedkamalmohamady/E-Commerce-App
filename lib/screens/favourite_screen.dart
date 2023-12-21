import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/cubits/home_cubit/home_cubit.dart';

import '../constants.dart';
import '../widgets/custom_fav_card.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,

        title: Text('Favourite Products',
            style: customTextStyle(
                fontWeight: FontWeight.bold, fontSize: 22.sp,color: kPrimaryColor)),
        backgroundColor: Colors.transparent,

      ),
      body: BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {

        return HomeCubit.get(context).favouritesIsReady==null?const LinearProgressIndicator(color: kPrimaryColor,):HomeCubit.get(context).favProducts!.data!.FavProducts!.isNotEmpty?
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

             SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    var products =
                    HomeCubit.get(context).favProducts!.data!.FavProducts!;
                    var product=products[index].product;
                    return customFavCard(product!,context);
                  },
                  separatorBuilder: (context, index) {
                    return  SizedBox(
                      height: 20.h,
                      child: Divider(
                        color: Colors.black12,
                        thickness: 2,
                        endIndent: 30.w,
                        indent: 30.w,
                      ),
                    );
                  },
                  itemCount: HomeCubit.get(context).favProducts!.data!.FavProducts!.length
              ),
            ),
          ],
        )
        :const Center(child: Text('No favourites yet ',style: TextStyle(color: kPrimaryColor,fontSize: 20),));
      },
    ),
    );
  }
}


