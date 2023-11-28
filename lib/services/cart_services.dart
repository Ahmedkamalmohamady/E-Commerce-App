import 'package:dio/dio.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/helper/api.dart';
import 'package:shop_app/models/cart_model.dart';

class CartServices
{

  static Future<CartModel> addToCart(id)
  async {

  Response response=await Api.post(
      endpoint: 'carts',
      headers: {},
      body: {
        "product_id": id.toString()
        },
    token: token
  );
  CartModel cartModel=CartModel.fromJson(response.data);
return cartModel;
  }



}