
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/cubits/home_cubit/home_cubit.dart';
import 'package:shop_app/screens/shimmer/home_shimmer.dart';

import '../widgets/categories_list.dart';
import '../widgets/custom_grid_view.dart';
import '../widgets/custom_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon:  Icon(
                Icons.search_rounded,
                color: kPrimaryColor,
                size: 30.spMax,
              )),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Taswe2a',
              style: customTextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.sp,
                letterSpacing: -1.20
              ),
            ),
             Icon(
              size: 30.spMax,
              LineAwesomeIcons.shopping_cart,
              color: kPrimaryColor,
            )
          ],
        ),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          if (HomeCubit.get(context).homeData.data!=null) {
            var products = HomeCubit.get(context).homeData.data!.products;
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSlider(model: HomeCubit.get(context).homeData),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Categories',
                        style: customTextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22.sp)),
                  ),
                  const CategoriesListView(),
                  Padding(
                    padding:  EdgeInsets.symmetric(
                        horizontal: 10.0.w, vertical: 20.h),
                    child: Text('All Products',
                        style: customTextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22.sp)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomGridView(products: products),
                  ),
                ],
              ),
            );
          }
          return HomeShimmer();
        },
      ),
    );
  }
}




