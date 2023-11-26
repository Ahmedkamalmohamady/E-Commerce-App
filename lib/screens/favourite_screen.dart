import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/home_cubit/home_cubit.dart';
import 'package:shop_app/models/home_model.dart';

import '../constants.dart';
import '../models/favourites_model.dart';
import '../services/favourites_services.dart';
import '../widgets/custom_grid_view.dart';
import '../widgets/custom_widgets.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,

        title: Text('Favourite Products',
            style: customTextStyle(
                fontWeight: FontWeight.bold, fontSize: 22,color: kPrimaryColor)),
        backgroundColor: Colors.transparent,
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {

        return HomeCubit.get(context).favouritesIsReady==null?LinearProgressIndicator(color: kPrimaryColor,):HomeCubit.get(context).favProducts!.data?.FavProducts!= null?
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    var products =
                    HomeCubit.get(context).favProducts!.data!.FavProducts!;
                    var product=products[index].product;
                    return customFavCard(product,context);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 20,
                      child: Divider(
                        color: Colors.black12,
                        thickness: 2,
                        endIndent: 30,
                        indent: 30,
                      ),
                    );
                  },
                  itemCount: HomeCubit.get(context).favProducts!.data!.FavProducts!.length
              ),
            ),
          ],
        )
        :Center(child: Text('No Favourites Found ',style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.bold),));
      },
    ),
    );
  }
}

Widget customFavCard(product,context) => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            CachedNetworkImage(
              width: 120,
              height: 120,
              fit: BoxFit.contain,
              imageUrl: product!.image!,
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
        ),
        InkWell(
            onTap: () async{
              HomeCubit.get(context).changeFavourite(product.id);
            },

            splashFactory: InkSparkle.splashFactory,
            child: HomeCubit.get(context).favourites[product.id]!?CircleAvatar(backgroundColor: Colors.black12,child: Icon(CupertinoIcons.heart_solid,color: kPrimaryColor,)):CircleAvatar(
              backgroundColor: Colors.black12,child: const Icon(Icons.favorite_border,
                color: Colors.black45, size: 30),
            )),
      ],
    );
