import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/cubits/cart_cubit/cart_cubit.dart';
import 'package:shop_app/cubits/home_cubit/home_cubit.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/screens/product_details.dart';

Widget customItemCard(Product product,context) => SizedBox(
  child:   InkWell(
    onTap: (){
      print(product.id);
      print(HomeCubit.get(context).favourites[product.id]);
      Navigator.push(context, MaterialPageRoute(builder: (context) =>ProductDetails(product: product),));
    },
    child: Stack(
      children: [
        Card(

          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  CachedNetworkImage(
                    width: 180.w,
                    height: 105.h,
                    fit: BoxFit.contain,
                    imageUrl: product.image!,
                    errorWidget: (context, url, error) {
                      return Column(
                        children: [
                          const Icon(Icons.error_outline),
                           SizedBox(
                            height: 8.h,
                          ),
                          Text(error.toString())
                        ],
                      );
                    },
                    placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                  ),
                  if (product.discount != 0)
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 5.0.w),
                      child: Container(
                        height: 22.w,
                        width: 80.w,
                        color: Colors.redAccent,
                        child:  Center(
                            child: Text(
                              'DISCOUNT',
                              style: TextStyle(
                                fontSize: 14.sp,
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                  Positioned(
                    top: 0,
                    right: 2.w,
                    child: Padding(
                      padding:  EdgeInsets.all(8.0.w),
                      child: InkWell(
                          onTap: () async{
                            HomeCubit.get(context).changeFavourite(product.id);
                          },

                          splashFactory: InkSparkle.splashFactory,
                          child: HomeCubit.get(context).favourites[product.id]!?const CircleAvatar(backgroundColor: Colors.black12,child: Icon(CupertinoIcons.heart_solid,color: kPrimaryColor,)):CircleAvatar(
                            backgroundColor: Colors.black12,child:  Icon(Icons.favorite_border,
                              color: Colors.black45, size: 30.sp),
                          )),
                    ),
                  )
                ],
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.0.w),
                child: Column(
                  children: [
                     SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                        width: 180.w,
                        child: Text(
                          product.name!,
                          style: customTextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w600),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )),
                     SizedBox(height: 10.h),

                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${product.price.round().toString()} L.E',
                          style: customTextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor)),

                      if (product.discount != 0)
                        Text('${product.oldPrice.round().toString()} L.E',

                            style: customTextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                                decorationThickness: 3,
                                decorationColor: Colors.red)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 22.h,
          right: 10.w,
          child: InkWell(
              onTap: () async{
                CartCubit.get(context).AddOrRemoveProductToCart(product.id);
              },

              splashFactory: InkSparkle.splashFactory,
              child:  CircleAvatar(backgroundColor: Colors.black12,child: Icon(LineAwesomeIcons.add_to_shopping_cart,size: 30.spMax,color: kPrimaryColor,))),
        ),
      ],
    ),
  ),
);

Widget customShimmerCard() => SizedBox(
  child:Container(
    width: 180.w,
    height: 220.h,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
    ),
  ),
);
