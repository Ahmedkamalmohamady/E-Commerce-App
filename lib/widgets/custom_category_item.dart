import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/screens/categories_screen.dart';

import '../cubits/home_cubit/home_cubit.dart';
import 'custom_item_card.dart';

Widget customCategoryItem(CategoryData category,context) => SizedBox(

  child: InkWell(
    onTap: () {

      Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesScreen(id:category.id,title:category.name),));
    },
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
  ),
);


Widget customShimmerCategoryItem() => SizedBox(

  child: Card(
    // color: Colors.transparent,
    elevation: 5,
    shadowColor: Colors.black26,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Row(
      children: [


        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(width: 150),
        ),


        ClipRRect(

          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 90,
              height: 90,
              color: Colors.white,
            ),
          ),
        ),

      ],
    ),
  ),
);
class CustomShimmerCategoryProduct extends StatelessWidget {
  const CustomShimmerCategoryProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30,),
            GridView.count(
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: .8,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: [
                customShimmerCard(),
                customShimmerCard(),
                customShimmerCard(),
                customShimmerCard(),
                customShimmerCard(),
                customShimmerCard(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}