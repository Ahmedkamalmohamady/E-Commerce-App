

import 'package:shop_app/models/home_model.dart';

class CartModel
{
final String message;
final bool status;
final CartModelData data;

  CartModel({required this.message, required this.status, required this.data});

factory CartModel.fromJson(json)
{
  return CartModel(
      message: json['message'],
      status: json['status'],
      data: CartModelData.fromJson(json['data'])
  );


}



}
class CartModelData
{
final int id;
final int  quantity ;
final Product product;

  CartModelData({required this.id, required this.quantity, required this.product});

factory CartModelData.fromJson(json)
{
  return CartModelData(
      id: json['id'],
      quantity: json['quantity'],
      product: Product.fromJson(json['product'])
  );
}

}
class MyCartModel
{
  final dynamic message;
  final bool status;
  final MyCartDataModel data;

  MyCartModel({required this.message, required this.status, required this.data});

  factory MyCartModel.fromJson(json)
  {
    return MyCartModel(
        message: json['message'],
        status: json['status'],
        data: MyCartDataModel.fromJson(json['data'])
    );
  }

}
class MyCartDataModel
{
  final List<CartModelData> cartItems;
  final dynamic subTotal;
  final dynamic total;

  MyCartDataModel({required this.cartItems, required this.subTotal, required this.total});
  factory MyCartDataModel.fromJson(json)
  {
    List<CartModelData>items=[];
    if(json['cart_items']!=[])
    {
      json['cart_items'].forEach((e)
      {
        items.add(CartModelData.fromJson(e));
      });
    }
    return MyCartDataModel(

        cartItems:items,
        subTotal: json['sub_total'],
        total: json['total']
    );
  }

}