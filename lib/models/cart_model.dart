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