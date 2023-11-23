import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/home_cubit/home_cubit.dart';
import 'package:shop_app/models/home_model.dart';

import '../constants.dart';
import '../widgets/custom_grid_view.dart';

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
        backgroundColor: Colors.white,
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var products =
        HomeCubit.get(context).favProducts!.data!.FavProducts!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    var product=products[index].product;
                    return customFavCard(product);
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
                  itemCount:products.length
              ),
            ),
          ],
        );
      },
    ),
    );
  }
}

Widget customFavCard(product) => Row(
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
            onTap: () {},
            splashColor: Colors.red,
            splashFactory: InkSparkle.splashFactory,
            child: const Icon(Icons.favorite_border,
                color: Colors.black45, size: 30)),
      ],
    );
