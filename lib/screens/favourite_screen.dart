import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/home_cubit/home_cubit.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/screens/product_details.dart';

import '../constants.dart';
import '../models/favourites_model.dart';
import '../services/favourites_services.dart';
import '../widgets/custom_fav_card.dart';
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
                    return customFavCard(product!,context);
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


