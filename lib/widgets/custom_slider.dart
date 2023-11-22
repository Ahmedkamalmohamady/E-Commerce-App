import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/home_model.dart';

import 'custom_banner.dart';

class CustomSlider extends StatelessWidget {
  final HomeModel model;

  const CustomSlider({
    required this.model,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: List.generate(
          model.data!.banners!.length,
              (index) {
            return customBanner(model.data!.banners![index].image);
          }),
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
    );
  }
}