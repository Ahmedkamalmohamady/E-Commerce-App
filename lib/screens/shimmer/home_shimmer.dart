import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/widgets/custom_banner.dart';
import 'package:shop_app/widgets/custom_category_item.dart';
import 'package:shop_app/widgets/custom_item_card.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                items: [
                  customShimmerBanner(),
                  customShimmerBanner(),
                  customShimmerBanner(),
                  customShimmerBanner(),
                ],
                options: CarouselOptions(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  height: 160,
                  animateToClosest: true,
                  autoPlayAnimationDuration: Duration(seconds: 3),
                  autoPlay: true,
                  autoPlayCurve: Curves.easeInOut,
                  reverse: false,


                ),
              ),
              SizedBox(width: 30,),
              SizedBox(
                height: 100,
                child: ListView(
                  shrinkWrap: true,

                  scrollDirection: Axis.horizontal,
                  children: [
                    customShimmerCategoryItem(),
                    customShimmerCategoryItem(),
                    customShimmerCategoryItem(),

                  ],
                ),
              ),
              SizedBox(height: 20,),
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
                ],
              )
            ],
          ),
        ),

    );
  }
}
