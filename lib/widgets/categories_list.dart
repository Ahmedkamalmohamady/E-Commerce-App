import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubits/home_cubit/home_cubit.dart';
import 'custom_category_item.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 90.h,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: HomeCubit.get(context).categories!.data!.data!.length,
          itemBuilder: (context, index) => customCategoryItem(
              HomeCubit.get(context).categories!.data!.data![index],context),
        ),
      ),
    );
  }
}