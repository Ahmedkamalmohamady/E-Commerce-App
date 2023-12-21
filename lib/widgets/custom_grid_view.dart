import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/widgets/custom_item_card.dart';

import '../models/home_model.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    super.key,
    required this.products,
  });

  final List<Product>? products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .7,
          mainAxisSpacing: 5.h,
          crossAxisSpacing: 2.w,
        ),
        itemBuilder: (context, index) => customItemCard(products![index],context),
        itemCount: products!.length,
      ),
    );
  }
}