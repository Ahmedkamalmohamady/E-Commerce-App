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

  Future<void> getMyCart() async {
    emit(GetCartLoading());
    myCart = await CartServices.getMyCart();
    if (myCart!.status) {
      cartItems = myCart!.data.cartItems.length;
      emit(GetCartSuccess());
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

  void removeProductFromCart(id) async {
    var response = await CartServices.removeProduct(id);
    bool status=response.data["status"];
    if(status)
    {
      await getMyCart();
      emit(UpdatedSuccessfully());
    }
    print(status);
  }
}
