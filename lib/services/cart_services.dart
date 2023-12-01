import 'package:dio/dio.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/helper/api.dart';
import 'package:shop_app/models/cart_model.dart';

class CartServices
{

  static Future<CartModel> addOrRemoveFromCart(id)
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

  static Future<MyCartModel> getMyCart()
  async {
    Response response=await Api.get(
        endpoint: 'carts',
        token: token
    );
    MyCartModel myCart=MyCartModel.fromJson(response.data);
    print('cart products :${myCart.data.cartItems.length}');
    return myCart;
  }
  static Future<Response>updateProductQuantity(id,count)
  async{
    var response=await Api.put(
        token: token,
        headers:
        {'Authorization': '$token',},
        endpoint: 'carts/$id',
        body: {
          "quantity":count
        }
    );
  return response;
  }
  static Future<Response>removeProduct(id)
  async{
    var response=await Api.delete(
        token: token,
        headers: {'Authorization': '$token'},
        endpoint: 'carts/$id',
    );
    return response;
  }
}