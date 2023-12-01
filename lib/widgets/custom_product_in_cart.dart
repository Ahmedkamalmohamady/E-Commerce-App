import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return Container(
      width: size.width,
      height: size.height*.15,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Color(0xFFF2F2F2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: size.width*.3,
            child: CachedNetworkImage(imageUrl: product.product.image!,fit: BoxFit.contain,placeholder: (context, url) {
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
                    CartCubit.get(context).removeProductFromCart(product.id);
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
                          count=product.quantity-1;
                          if(count==0)
                          {
                            CartCubit.get(context).removeProductFromCart(product.id);
                          }
                          else {
                            CartCubit.get(context).UpdateProductQuantity(
                                product.id, count.toString());
                          }
                        },
                        child: Container(
                            padding: const EdgeInsets.all(5.94),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Color(0xFFF2F2F2),
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
                        child: Text(product.quantity.toString(),style: customTextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                      ),
                      SizedBox(width: 5,),
                      InkWell(
                        onTap: () {
                          count=product.quantity+1;
                          CartCubit.get(context).UpdateProductQuantity(product.id, count.toString());
                          print(count);
                        },
                        child: Container(
                            padding: const EdgeInsets.all(5.94),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Color(0xFFF2F2F2),
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
                      )
                    ],),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}