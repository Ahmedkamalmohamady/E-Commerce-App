import 'package:shop_app/constants.dart';
import 'package:shop_app/helper/api.dart';

import '../models/favourites_model.dart';

class FavouritesServices
{

 static Future<FavouritesModel>favouriteAction(id)
  async{
    var response=await Api.post(
        endpoint: favEndPoint,
        body: {
          'product_id':id.toString()
        },
      headers: {'Authorization': token},
    );
    print(token);
    FavouritesModel favRsponse=FavouritesModel.fromJson(response.data);
    print(favRsponse.message);
    print(favRsponse.status);
    return favRsponse;
  }





}