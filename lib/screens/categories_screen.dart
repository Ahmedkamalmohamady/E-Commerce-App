import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/cubits/home_cubit/home_cubit.dart';
import 'package:shop_app/widgets/custom_grid_view.dart';

import '../widgets/custom_item_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key, this.id, this.title}) : super(key: key);
final id ;
final title;
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<HomeCubit,HomeState>(
      bloc: HomeCubit()..getProductsForCategory(id),
     builder: (context, state)
     {

         return Scaffold(
           appBar: AppBar(
             title: Text(title,style: customTextStyle(fontWeight: FontWeight.w600)),
           ),
           body:state is GetProductsForCategorySuccess?
             SingleChildScrollView(
         child:Column(
           children: [
             SizedBox(height: 30,),
             CustomGridView( products:state.products),
           ],
         )
       ,
       ):Shimmer.fromColors(
               baseColor: Colors.grey.shade300,
             highlightColor: Colors.grey.shade100,
               child: SingleChildScrollView(
                 child: Column(
                   children: [
                     SizedBox(height: 30,),
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
           )
         );




     },
    );
  }
}
