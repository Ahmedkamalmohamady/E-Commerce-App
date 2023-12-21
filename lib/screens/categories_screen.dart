import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shop_app/constants.dart';
import 'package:shop_app/cubits/home_cubit/home_cubit.dart';
import 'package:shop_app/widgets/custom_grid_view.dart';

import '../widgets/custom_category_item.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key, this.id, this.title}) : super(key: key);
final id ;
final title;
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<HomeCubit, HomeState>(
      bloc: HomeCubit.get(context)..getProductsForCategory(id),
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                  textAlign: TextAlign.center,title.toString().toUpperCase(),style: customTextStyle(fontWeight: FontWeight.w600,color: kPrimaryColor,fontSize: 22.sp)),
            ),
            body:state is GetProductsForCategoryLoading ?const CustomShimmerCategoryProduct():HomeCubit.get(context).products!=null
                ?SingleChildScrollView(
              child:Column(
                children: [
                   SizedBox(height: 28.h,),
                  CustomGridView( products:HomeCubit.get(context).products),
                ],
              )
              ,
            ):
            const CustomShimmerCategoryProduct()
        );
      },
    );
  }
}


