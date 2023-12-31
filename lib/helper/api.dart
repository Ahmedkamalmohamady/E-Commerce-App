import 'dart:convert';

import 'package:dio/dio.dart';


class Api {
 static String baseUrl = 'https://student.valuxapps.com/api/';

  ///getMethod
  static Future<Response> get(
      {token,
       queryParameters,
      required String endpoint}) async {
    Map<String, String> headers = {
      'Content-Type':'application/json',
      'lang':'en',
    };
    if (token != null) {
      headers.addAll({'Authorization': '$token'});
    }
    var dio = Dio();
    var response = await dio.get(baseUrl+endpoint,
        options: Options(
          headers: headers,
        ),
        queryParameters: queryParameters);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception(
          'There is problem with status code ${response.statusCode} with body : ${jsonDecode(response.data)}');
    }
  }


  ///postMethod
  static Future<Response> post(
      {token,
        queryParameters,
        Map<String,String>? headers,
        required String endpoint,
        required Map<String,String>body
      }) async {

    if (token != null) {
      headers?.addAll({'Authorization': token,});
    }
    var dio = Dio();
    Response response = await dio.post(baseUrl+endpoint,
        options: Options(
          headers: headers,
        ),
        data: body,
        queryParameters: queryParameters,
    );
    if (response.statusCode == 200) {
      print(headers);
      return response;
    } else {
      throw Exception(
          'There is problem with status code ${response.statusCode} with body : ${jsonDecode(response.data)}');
    }
  }



 ///putMethod
 static Future<Response> put(
     {required token,
       queryParameters,
       Map<String,String>? headers,
       required String endpoint,
       required Map<String,String>body
     }) async {
   if (token != null) {
     headers?.addAll({'Authorization': '$token',});
   }
   var dio = Dio();
   Response response = await dio.put(baseUrl+endpoint,
     options: Options(
       headers: headers,
     ),
     data: body,
     queryParameters: queryParameters,
   );
   if (response.statusCode == 200) {
     return response;
   } else {
     throw Exception(
         'There is problem with status code ${response.statusCode} with body : ${jsonDecode(response.data)}');
   }
 }

 ///postMethod
 static Future<Response> delete(
     {token,
       queryParameters,
       Map<String,String>? headers,
       required String endpoint,
        Map<String,String>?body
     }) async {
   if (token != null) {
     headers?.addAll({'Authorization': '$token',});
   }
   var dio = Dio();
   Response response = await dio.delete(baseUrl+endpoint,
     options: Options(
       headers: headers,
     ),
     data: body,
     queryParameters: queryParameters,
   );
   if (response.statusCode == 200) {
     return response;
   } else {
     throw Exception(
         'There is problem with status code ${response.statusCode} with body : ${jsonDecode(response.data)}');
   }
 }


}
