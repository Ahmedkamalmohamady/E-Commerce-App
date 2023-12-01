import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/services/cart_services.dart';

import '../../widgets/custom_widgets.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  static CartCubit get(context) => BlocProvider.of(context);
  MyCartModel? myCart;
  int? itemsCount;
  bool isLoading=false;
  int? cartItems;
  Map<int,int> productsInCart={};
  Map<int,bool> cartProducts={};



  Future<void> getMyCart() async {
    emit(GetCartLoading());
    myCart = await CartServices.getMyCart();

    if (myCart!.status) {
      cartItems = myCart!.data.cartItems.length;
      productsInCart={};
      for (var element in myCart!.data.cartItems) {
        productsInCart!.addAll(
            {
              element.id:element.quantity
            }
        );
      } for (var element in myCart!.data.cartItems) {
        cartProducts={};
        cartProducts!.addAll(
            {
              element.product.id!:element.product.inCart!
            }
        );
      }

      print(myCart!.data.cartItems.length);
      print(productsInCart);

      emit(GetCartSuccess());
      print(cartProducts);

    }
    else {
      emit(GetCartFailed());
    }
  }


  void AddOrRemoveProductToCart(id) async {
    isLoading =true;
    emit(AddingToCartLoading());

    CartModel response = await CartServices.addOrRemoveFromCart(id);
    if (response.status) {

      await getMyCart();
      isLoading=false;
      cartProducts[id]=!cartProducts[id]!;
      emit(AddingToCartSuccess(message: response.message));

      ShowToastMessage(msg: response.message, color: Colors.green);
    }
    else {
      isLoading=false;
      emit(AddingToCartFailed(message: response.message));
      ShowToastMessage(msg: response.message, color: Colors.red);
    }
  }

  void UpdateProductQuantity(id, count) async {
    var response = await CartServices.updateProductQuantity(id, count);
    bool status=response.data["status"];
    if(status)
    {
      await getMyCart();
      emit(UpdatedSuccessfully());
    }
    print(status);
  }

  void removeProductFromCart(product) async {
    var response = await CartServices.removeProduct(product.id);
    bool status=response.data["status"];
    if(status)
    {
      cartProducts[product.product.id]=!cartProducts[product.product.id]!;
      await getMyCart();
      emit(UpdatedSuccessfully());
    }
    print(status);
    await getMyCart().then((value) =>(value) {
    print(productsInCart);
    });

  }
  void increaseQuantity(id)
  {
    productsInCart[id]=productsInCart[id]!+1;
    emit(UpdatedSuccessfully());
   var count=productsInCart[id]!;
   UpdateProductQuantity(id, count.toString());
    print(productsInCart[id]);
  }
  void decreaseQuantity(product)
  {
    productsInCart[product.id]=productsInCart[product.id]!-1;
    emit(UpdatedSuccessfully());
    print(productsInCart[product.id]);
    var count=productsInCart[product.id]!;
  if(count==0)
    {
     removeProductFromCart(product);
    }
    else {
      UpdateProductQuantity(
      product.id, count.toString());
    }
  }
}
