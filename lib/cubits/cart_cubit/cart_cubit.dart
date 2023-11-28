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
static CartCubit get(context)=>BlocProvider.of(context);
  void AddOrRemoveProductToCart(id)
  async {
    emit( AddingToCartLoading());
  CartModel response=await CartServices.addToCart(id);
  if(response.status){
    emit(AddingToCartSuccess(message: response.message));
    ShowToastMessage(msg: response.message,color: Colors.green);

  }
  else{

    emit(AddingToCartFailed(message: response.message));
    ShowToastMessage(msg: response.message,color: Colors.red);


  }
}
}
