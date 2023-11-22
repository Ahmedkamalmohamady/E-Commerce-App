import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/category_model.dart';

Widget customCategoryItem(CategoryData category) => SizedBox(

  child: Card(
    // color: Colors.transparent,
    elevation: 5,
    shadowColor: Colors.black26,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Row(
      children: [


        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(width: 150,child: Text(category.name!.toUpperCase(),overflow: TextOverflow.ellipsis,maxLines: 2,style: customTextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: kPrimaryColor))),
        ),


        ClipRRect(

          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CachedNetworkImage(
              width: 90,
              height: 90,
              fit: BoxFit.fill,
              imageUrl: category.image!,
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
          ),
        ),

      ],
    ),
  ),
);