

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      bottomNavigationBar: products.isNotEmpty?Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
            border: Border.all(

                color: Colors.black.withOpacity(0.03),

            )
        ),

        // height: 230.h,
        // color: Colors.grey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.0.w,vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sub-total',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.sp,
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
                      style:  TextStyle(
                        color: kPrimaryColor,
                        fontSize: 18.sp,
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
              padding:  EdgeInsets.symmetric(horizontal: 20.0.w,vertical: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'VAT (%)',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.sp,
                      fontFamily: 'General Sans',
                      fontWeight: FontWeight.w400,
                      height: 0.09,
                      letterSpacing: -0.32,
                    ),
                  ),
                  Text(
                    '0.0  L.E' ,
                    style:  TextStyle(
                      color: kPrimaryColor,
                      fontSize: 18.sp,
                      fontFamily: 'General Sans',
                      fontWeight: FontWeight.w600,
                      height: 0,
                      letterSpacing: -0.48,
                    ),
                  ),

                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.0.w,vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shipping fee',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.sp,
                      fontFamily: 'General Sans',
                      fontWeight: FontWeight.w400,
                      height: 0.09,
                      letterSpacing: -0.32,
                    ),
                  ),
                  Text(
                    '0.0  L.E' ,
                    style:  TextStyle(
                      color: kPrimaryColor,
                      fontSize: 18.sp,
                      fontFamily: 'General Sans',
                      fontWeight: FontWeight.w600,
                      height: 0,
                      letterSpacing: -0.48,
                    ),
                  ),

                ],
              ),
            ),
            Divider(thickness: 2,indent: 20.w,endIndent: 20.w),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.0.w,vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.sp,
                      fontFamily: 'General Sans',
                      fontWeight: FontWeight.bold,
                      height: 0.09,
                      letterSpacing: -0.32,
                    ),
                  ),
                  Text(
                    '${total.round()}  L.E' ,
                    style:  TextStyle(
                      color: kPrimaryColor,
                      fontSize: 18.sp,
                      fontFamily: 'General Sans',
                      fontWeight: FontWeight.w600,
                      height: 0,
                      letterSpacing: -0.48,
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            CustomButton(onPressed: (){
              print(size.width );
            },text: 'Check out >',width: size.width*.8,textStyle: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontFamily: 'General Sans',
              fontWeight: FontWeight.w500,
              height: 0,
            ),),
            SizedBox(height: 20.h)
          ],
        ),
      ):null,
      appBar: AppBar(
        toolbarHeight: 25.h,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: SizedBox(),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 8.0.w),
        child: Column(
          children: [
            Row(
              children: [
                Spacer(flex: 1,),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child:  Icon(CupertinoIcons.back,color: Colors.grey,size: 30.spMin,)),
                Spacer(
                  flex: 8,
                ),
                Text(
                  'My Cart',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 24.sp,
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
            const SizedBox(height: 20,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  products.isNotEmpty?Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return CustomProductInCart(size: size,product: products[index],);
                        },
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: products.length
                    ),
                  ):Center(child: Text('No items yet',style: customTextStyle(color: kPrimaryColor,fontSize: 20,),)),

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


