import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_details.dart';

import '../constants.dart';
import '../cubits/cart_cubit/cart_cubit.dart';
import '../models/cart_model.dart';

class CustomProductInCart extends StatelessWidget {
  const CustomProductInCart({
    super.key,
    required this.size, required this.product,
  });
  final CartModelData product;
  final Size size;

  @override
  Widget build(BuildContext context) {
    int count=1;
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(product: product.product),));
      },
      child: Card(
        child: Container(
          width: size.width,
          height: size.height*.15,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: size.width*.25,
                child: CachedNetworkImage(width:size.width*.25,height:size.height*.15,imageUrl: product.product.image!,fit: BoxFit.fitWidth,placeholder: (context, url) {
                  return Center(child: CircularProgressIndicator());
                },),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: size.width*0.25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      product.product.name!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style:  TextStyle(
                        color: kPrimaryColor,
                        fontSize: 16,
                        fontFamily: 'General Sans',
                        fontWeight: FontWeight.w500,

                      ),),
                    SizedBox(height: 20,),
                    Text(
                      product.product.price!.toString() +' LE',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontFamily: 'General Sans',
                        fontWeight: FontWeight.w600,
                        height: 0,
                        letterSpacing: -0.28,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,

                  children: [
                    Align(alignment: Alignment.topRight,child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: IconButton(onPressed: (){
                        CartCubit.get(context).removeProductFromCart(product);
                        print(product.id);
                      }, icon: Icon(Icons.delete,color: Colors.red.shade300,)),
                    )),
                    SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap:() {
                              CartCubit.get(context).decreaseQuantity(product);


                            },
                            child: Container(
                                padding: const EdgeInsets.all(5.94),
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 0.64,
                                      color: Colors.black.withOpacity(0.20000000298023224),
                                    ),
                                    borderRadius: BorderRadius.circular(2.97),
                                  ),
                                ),
                                child: Icon(CupertinoIcons.minus,color: kPrimaryColor,)
                            ),
                          )
                          ,
                          SizedBox(width: 5,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(CartCubit.get(context).productsInCart[product.id].toString(),style: customTextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                          ),
                          SizedBox(width: 5,),
                          InkWell(
                            onTap: () {
                              CartCubit.get(context).increaseQuantity(product.id);

                             //  print(count);
                            },
                            child: Container(
                                padding: const EdgeInsets.all(5.94),
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 0.64,
                                      color: Colors.black.withOpacity(0.20000000298023224),
                                    ),
                                    borderRadius: BorderRadius.circular(2.97),
                                  ),
                                ),
                                child: Icon(CupertinoIcons.plus,color: kPrimaryColor,)
                            ),
                          ),
                          SizedBox(width: 5)
                        ],),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}