import 'package:dio/dio.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/helper/api.dart';

class UserServices
{
  Future<Response>login(
  {
  required String email,
  required String password,
}
)
  async{
Response  data =await Api.post(
  headers: {
    'lang':'en'
  },
    body: {
      'email':email,
      'password':password
    },
    endpoint:'login',
);

return data;

  }


  Future<Response>getUserProfile({required token})
  async{
    Response  data =await Api.get(

      token: token,
      endpoint:'profile',
    );

    return data;

  }



}