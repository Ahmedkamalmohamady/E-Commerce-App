import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/widgets/custom_widgets.dart';
import 'package:shop_app/widgets/description_text_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../cubits/cart_cubit/cart_cubit.dart';
import '../cubits/home_cubit/home_cubit.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key,required this.product}) : super(key: key);
  final Product product ;

  @override
  Widget build(BuildContext context) {
  PageController controller =PageController();
  var size=MediaQuery.of(context).size;

    return BlocBuilder<CartCubit,CartState>(
  builder: (context, state) {
    var isLoading=CartCubit.get(context).isLoading;
    var inCart=CartCubit.get(context).cartProducts;
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black.withOpacity(0.03)
          )
        ),
          height: 80.h,
          // color: Colors.grey,
        child: Row(
          children: [
            Padding(
              padding:  EdgeInsets.only(top: 15.0.h,left: 20.w),
              child: Column(
                children: [
                   Text(
                    'Price',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.sp,
                      fontFamily: 'General Sans',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: -0.32,
                    ),
                  ),
                  Text(
                    '${product.price}  L.E' ,
                    style:  TextStyle(
                      color: kPrimaryColor,
                      fontSize: 24.sp,
                      fontFamily: 'General Sans',
                      fontWeight: FontWeight.w600,
                      height: 0,
                      letterSpacing: -0.48,
                    ),
                  ),
                  product.discount != 0?Padding(
                    padding:  EdgeInsets.only(left: 50.0.w),
                    child: Text('${product.oldPrice.round().toString()} L.E',

                        style: customTextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 3,
                            decorationColor: Colors.red)),
                  ):const SizedBox(),
                ],
              ),
            ),
             SizedBox(
              width: 40.w,
            ),
            CustomButton(onPressed: (){
              CartCubit.get(context).AddOrRemoveProductToCart(product.id);
            },
              text: isLoading? null:inCart[product.id]!=null&&inCart[product.id]==false?'Remove from Cart':'Add to Cart',
              width: 180.w,textStyle: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontFamily: 'General Sans',
              fontWeight: FontWeight.w500,
              height: 0,
            ),)
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(8.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SizedBox(height: 60.w,),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                      child:  Icon(CupertinoIcons.back,color: Colors.grey,size: 30.spMax,)),
                   SizedBox(width: 30.w,),
                   Text(
                    'Details',
                    textAlign: TextAlign.center
                    ,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 24.sp,
                      fontFamily: 'General Sans',
                      fontWeight: FontWeight.w600,
                      height: 0.09,
                      letterSpacing: -1.20,
                    ),
                  ),
                ],
              ),
               SizedBox(height: 20.h,),
              Center(
                child: Container(
                  width: double.infinity,
                  height: 240.h,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Stack(
                    children: [
                     PageView(
                       controller: controller,
                       physics: const BouncingScrollPhysics(),
                       children:
                       List.generate(product.images!.length, (index){
                         return  Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: CachedNetworkImage(
                             placeholder: (context, url) {
                               return const Center(child: CircularProgressIndicator());
                             },
                               fit: BoxFit.contain,
                               width: double.infinity,
                               imageUrl: product.images![index]
                           ),
                         );
                       })
                     ,),
                      Positioned(
                        right: 10.w,
                        top: 10.h,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () async{
                                HomeCubit.get(context).changeFavourite(product.id);
                              },

                              splashFactory: InkSparkle.splashFactory,
                              child: HomeCubit.get(context).favourites[product.id]!? const CircleAvatar(backgroundColor: Colors.black12,child: Icon(CupertinoIcons.heart_solid,color: kPrimaryColor,)): CircleAvatar(
                                backgroundColor: Colors.black12,child: Icon(Icons.favorite_border,
                                  color: Colors.black45, size: 30.spMax),
                              )),
                        )

                      ),
                      Positioned(
                        left: size.width * 0.3,
                        right: size.width * 0.3,
                        bottom: 5,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SmoothPageIndicator(
                              controller: controller,
                              count: product.images!.length,
                              effect:  SlideEffect(
                                radius: 30.r,
                                dotHeight: 5.h,
                                dotWidth: 15.w,
                              ),
                            ),
                          ),
                        )

                      ),
                    ],
                  ),
                ),
              ),
              Text(
                 product.name!,
                style:  TextStyle(
                  fontSize: 24.sp,
                  fontFamily: 'General Sans',
                  fontWeight: FontWeight.w600,
                  height: 0,
                  // letterSpacing: -0.48,
                ),
              ),
               SizedBox(
                height: 15.h,
              ),
              DescriptionTextWidget(text: product.description!),
               SizedBox( height: 10.h,),

            ],
          ),
        )
      ),
    );
  },
);
  }
}
