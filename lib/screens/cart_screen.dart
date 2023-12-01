

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/cubits/cart_cubit/cart_cubit.dart';

import '../widgets/custom_product_in_cart.dart';
import '../widgets/custom_widgets.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   var size=MediaQuery.of(context).size;
    return BlocConsumer<CartCubit, CartState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var products=CartCubit.get(context).myCart!.data.cartItems;
    var  total=CartCubit.get(context).myCart!.data.total;
    var  subtotal=CartCubit.get(context).myCart!.data.subTotal;
    return Scaffold(
      bottomNavigationBar: products.length!=0?Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
            border: Border.all(

                color: Colors.black.withOpacity(0.03),

            )
        ),

        height: 260,
        // color: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sub-total',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: 'General Sans',
                      fontWeight: FontWeight.w400,
                      height: 0.09,
                      letterSpacing: -0.32,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: .0),
                    child: Text(
                      '${(subtotal).round()}  L.E' ,
                      style: const TextStyle(
                        color: kPrimaryColor,
                        fontSize: 18,
                        fontFamily: 'General Sans',
                        fontWeight: FontWeight.w600,
                        height: 0,
                        letterSpacing: -0.48,
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'VAT (%)',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: 'General Sans',
                      fontWeight: FontWeight.w400,
                      height: 0.09,
                      letterSpacing: -0.32,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: .0),
                    child: Text(
                      '0.0  L.E' ,
                      style: const TextStyle(
                        color: kPrimaryColor,
                        fontSize: 18,
                        fontFamily: 'General Sans',
                        fontWeight: FontWeight.w600,
                        height: 0,
                        letterSpacing: -0.48,
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shipping fee',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: 'General Sans',
                      fontWeight: FontWeight.w400,
                      height: 0.09,
                      letterSpacing: -0.32,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: .0),
                    child: Text(
                      '0.0  L.E' ,
                      style: const TextStyle(
                        color: kPrimaryColor,
                        fontSize: 18,
                        fontFamily: 'General Sans',
                        fontWeight: FontWeight.w600,
                        height: 0,
                        letterSpacing: -0.48,
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Divider(thickness: 2,indent: 20,endIndent: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: 'General Sans',
                      fontWeight: FontWeight.bold,
                      height: 0.09,
                      letterSpacing: -0.32,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: .0),
                    child: Text(
                      '${total.round()}  L.E' ,
                      style: const TextStyle(
                        color: kPrimaryColor,
                        fontSize: 18,
                        fontFamily: 'General Sans',
                        fontWeight: FontWeight.w600,
                        height: 0,
                        letterSpacing: -0.48,
                      ),
                    ),
                  ),

                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(onPressed: (){
              print(size.width );
            },text: 'Check out >',width: size.width*.8,textStyle:const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'General Sans',
              fontWeight: FontWeight.w500,
              height: 0,
            ),),
            SizedBox(height: 20)
          ],
        ),
      ):null,
      appBar: AppBar(
        toolbarHeight: 30,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Row(
              children: [
                Spacer(flex: 1,),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(CupertinoIcons.back,color: Colors.grey,size: 30,)),
                Spacer(
                  flex: 8,
                ),
                Text(
                  'My Cart',
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
                Spacer(
                  flex: 8,
                )
              ],
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  products.length!=0?Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return CustomProductInCart(size: size,product: products[index],);
                        },
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: products.length
                    ),
                  ):Center(child: Text('No items yet')),

                ],
              ),
            ),

         
          ],
        ),
      ),
    );
  },
);
  }
}


