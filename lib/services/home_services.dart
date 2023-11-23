import 'package:shop_app/constants.dart';
import 'package:shop_app/helper/api.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/favourites_model.dart';

import '../models/home_model.dart';

class HomeServices
{
static Future<HomeModel>getHomeData()
async{
 var jsonData=await Api().get(
     endpoint: homeEndPoint,
   token: token,

 );
  HomeModel homeData=  HomeModel.fromJson(jsonData.data);
  return homeData;
}
static Future<CategoryModel>getCategories()
async{
  var jsonData=await Api().get(
    endpoint: categoryEndPoint,

  );
  CategoryModel categories=  CategoryModel.fromJson(jsonData.data);
  return categories;
}

static Future<List<Product>>getProductsForCategory(int id)
async{
  var jsonData=await Api().get(
    endpoint: "categories/$id",
    token: token,

  );

  List<Product> products = [];
  if (jsonData.data['data']['data'] != null) {

    jsonData.data['data']['data'].forEach((v) {
      products.add(Product.fromJson(v));
    });
  }
  return products;
}
///
static Future<FavouritesModel>getFavProducts()
async{
  var jsonData=await Api().get(
    endpoint: favEndPoint,
    token: token,

  );
  FavouritesModel favourites=  FavouritesModel.fromJson(jsonData.data);
  return favourites;
}

}