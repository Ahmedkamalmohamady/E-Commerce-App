import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/cubits/cart_cubit/cart_cubit.dart';
import 'package:shop_app/cubits/home_cubit/home_cubit.dart';
import 'package:shop_app/models/favourites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/screens/product_details.dart';
import 'package:shop_app/services/favourites_services.dart';
import 'package:shop_app/widgets/custom_widgets.dart';

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
                    width: 210,
                    height: 180,
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
                        height: 25,
                        width: 90,
                        color: Colors.redAccent,
                        child: const Center(
                            child: Text(
                              'DISCOUNT',
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                  Positioned(
                    top: 0,
                    right: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: () async{
                            HomeCubit.get(context).changeFavourite(product.id);
                          },

                          splashFactory: InkSparkle.splashFactory,
                          child: HomeCubit.get(context).favourites[product.id]!?CircleAvatar(backgroundColor: Colors.black12,child: Icon(CupertinoIcons.heart_solid,color: kPrimaryColor,)):CircleAvatar(
                            backgroundColor: Colors.black12,child: const Icon(Icons.favorite_border,
                              color: Colors.black45, size: 30),
                          )),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: 190,
                        child: Text(
                          product.name!,
                          style: customTextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )),
                    const SizedBox(height: 10),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('${product.price.round().toString()} L.E',
                          style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor)),
                    ),

                    if (product.discount != 0)
                      Text('${product.oldPrice.round().toString()} L.E',

                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              decorationThickness: 3,
                              decorationColor: Colors.red)),
                  ],
                ),
              )
            ],
          ),
        ),
        InkWell(
            onTap: () async{
              CartCubit.get(context).AddOrRemoveProductToCart(product.id);
            },

            splashFactory: InkSparkle.splashFactory,
            child: CircleAvatar(backgroundColor: Colors.black12,child: Icon(LineAwesomeIcons.add_to_shopping_cart,size: 30,color: kPrimaryColor,))),
      ],
    ),
  ),
);

Widget customShimmerCard() => SizedBox(
  child:Container(
    width: 180,
    height: 220,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
    ),
  ),
);
