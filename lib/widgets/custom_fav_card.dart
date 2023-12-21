import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/models/home_model.dart';

import '../constants.dart';
import '../cubits/home_cubit/home_cubit.dart';

Widget customFavCard(Product product,context) => Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    InkWell(
      onTap: () {
        //Navigator.push(context, MaterialPageRoute(builder: (context) =>ProductDetails(product: product),));

      },
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          CachedNetworkImage(
            width: 110.w,
            height: 110.w,
            fit: BoxFit.contain,
            imageUrl: product.image!,
            errorWidget: (context, url, error) {
              return Column(
                children: [
                  const Icon(Icons.error_outline),
                  const SizedBox(
                    height: 10,
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
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Container(
                height: 25.h,
                width: 90.w,
                color: Colors.redAccent,
                child: const Center(
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
              ),
            ),
        ],
      ),
    ),
    Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.0.w
      ),
      child: Column(
        children: [
           SizedBox(
            height: 8.h,
          ),
          SizedBox(
              width: 150.w,
              child: Text(
                product.name!,
                style: customTextStyle(
                    fontSize: 16.sp, fontWeight: FontWeight.w600),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
           SizedBox(height: 8.h),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('${product.price.round().toString()} L.E',
                    style: customTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor)),
              ),
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
          )
        ],
      ),
    ),
    InkWell(
        onTap: () async{
          HomeCubit.get(context).changeFavourite(product.id);
        },

        splashFactory: InkSparkle.splashFactory,
        child: HomeCubit.get(context).favourites[product.id]!?const CircleAvatar(backgroundColor: Colors.black12,child: Icon(CupertinoIcons.heart_solid,color: kPrimaryColor,)):CircleAvatar(
          backgroundColor: Colors.black12,child:  Icon(Icons.favorite_border,
            color: Colors.black45, size: 30.sp),
        )),
  ],
);