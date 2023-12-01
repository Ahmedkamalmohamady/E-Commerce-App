import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          width: 390,
          height: 101,
          // color: Colors.grey,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0,left: 20),
              child: Column(
                children: [
                  const Text(
                    'Price',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: 'General Sans',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: -0.32,
                    ),
                  ),
                  Text(
                    product.price.toString()+'  L.E' ,
                    style: const TextStyle(
                      color: kPrimaryColor,
                      fontSize: 24,
                      fontFamily: 'General Sans',
                      fontWeight: FontWeight.w600,
                      height: 0,
                      letterSpacing: -0.48,
                    ),
                  ),
                  product.discount != 0?Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Text('${product.oldPrice.round().toString()} L.E',

                        style: customTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 3,
                            decorationColor: Colors.red)),
                  ):const SizedBox(),
                ],
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            CustomButton(onPressed: (){
              CartCubit.get(context).AddOrRemoveProductToCart(product.id);
              print(inCart[product.id]);
            },
              text: isLoading? null:inCart[product.id]!=null&&inCart[product.id]==false?'Remove from Cart':'Add to Cart',
              width: 200,textStyle:const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'General Sans',
              fontWeight: FontWeight.w500,
              height: 0,
            ),)
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80,),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                      child: const Icon(CupertinoIcons.back,color: Colors.grey,size: 30,)),
                  const SizedBox(width: 30,),
                  const Text(
                    'Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 24,
                      fontFamily: 'General Sans',
                      fontWeight: FontWeight.w600,
                      height: 0.09,
                      letterSpacing: -1.20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Center(
                child: Container(
                  width: double.infinity,
                  height: 300,
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
                        right: 10,
                        top: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () async{
                                HomeCubit.get(context).changeFavourite(product.id);
                              },

                              splashFactory: InkSparkle.splashFactory,
                              child: HomeCubit.get(context).favourites[product.id]!?const CircleAvatar(backgroundColor: Colors.black12,child: Icon(CupertinoIcons.heart_solid,color: kPrimaryColor,)):const CircleAvatar(
                                backgroundColor: Colors.black12,child: Icon(Icons.favorite_border,
                                  color: Colors.black45, size: 30),
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
                              effect: const SlideEffect(
                                radius: 30,
                                dotHeight: 5,
                                dotWidth: 15,
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
                style: const TextStyle(
                  fontSize: 24,
                  fontFamily: 'General Sans',
                  fontWeight: FontWeight.w600,
                  height: 0,
                  // letterSpacing: -0.48,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DescriptionTextWidget(text: product.description!),
              const SizedBox( height: 20,),

            ],
          ),
        )
      ),
    );
  },
);
  }
}
