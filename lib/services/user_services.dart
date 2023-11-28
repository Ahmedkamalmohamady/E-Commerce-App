import 'package:dio/dio.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/helper/api.dart';
import 'package:shop_app/models/login_model.dart';

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


  Future<LoginModel> getUserProfile({required token})
  async{
    Response  data = await Api.get(

      token: token,
      endpoint:'profile',
    );

    return LoginModel.fromJson(data!.data);

  }

  Future<LoginModel>updateUserProfile({required token,required String name,required String email,required String password,dynamic?phone,required String image})
  async{
    Response  data =await Api.put(
      headers: {},
      body: {
        "name": name,
        "phone": phone,
        "email": email,
        "password": password,
        "image": image,
      },
      token: token,
      endpoint:'update-profile',
    );

    return LoginModel.fromJson(data.data);

  }

  Future<LoginModel>registerUser({required String name,required String email,required String password,dynamic?phone})
  async{
    Response  data =await Api.post(
      body: {
        "name": name,
        "phone": phone,
        "email": email,
        "password": password,
      },
      endpoint:'register',
    );

    return LoginModel.fromJson(data.data);

  }



}